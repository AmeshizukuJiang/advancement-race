#!/usr/bin/env python3
"""Generate Advancement Race datapack files from the manifest and a server jar.

This phase accepts an already-downloaded, official Minecraft server artifact via
--server-jar. Downloading, Mojang metadata hash validation, and persistent
caching are intentionally added in the following phase.
"""

from __future__ import annotations

import argparse
import io
import json
import re
import sys
import zipfile
from pathlib import Path
from typing import Any


REPO_ROOT = Path(__file__).resolve().parent.parent
DEFAULT_CONFIG = REPO_ROOT / "tools" / "generator.config.json"
DEFAULT_MANIFEST = REPO_ROOT / "tools" / "advancements.manifest.json"
DEFAULT_OVERRIDES = REPO_ROOT / "tools" / "advancement-overrides"
KEY_PATTERN = re.compile(r"^[a-z0-9_]+$")


class GeneratorError(Exception):
    """An invalid generator input or an unreadable Minecraft resource."""


def read_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError as error:
        raise GeneratorError(f"Missing file: {path}") from error
    except json.JSONDecodeError as error:
        raise GeneratorError(f"Invalid JSON in {path}: {error}") from error


def require_mapping(value: Any, description: str) -> dict[str, Any]:
    if not isinstance(value, dict):
        raise GeneratorError(f"{description} must be a JSON object.")
    return value


def require_string(value: Any, description: str) -> str:
    if not isinstance(value, str) or not value:
        raise GeneratorError(f"{description} must be a non-empty string.")
    return value


def validate_config(config: Any) -> dict[str, Any]:
    config = require_mapping(config, "Generator config")
    if config.get("schema_version") != 1:
        raise GeneratorError("Generator config schema_version must be 1.")

    minecraft = require_mapping(config.get("minecraft"), "Generator config minecraft")
    version = require_string(minecraft.get("version"), "Generator config minecraft.version")
    artifact = require_string(minecraft.get("artifact"), "Generator config minecraft.artifact")
    require_string(
        minecraft.get("version_manifest_url"),
        "Generator config minecraft.version_manifest_url",
    )
    if artifact != "server":
        raise GeneratorError("Generator MVP supports only the Minecraft server artifact.")
    return {"version": version}


def validate_manifest(manifest: Any) -> list[dict[str, Any]]:
    manifest = require_mapping(manifest, "Advancement manifest")
    if manifest.get("schema_version") != 1:
        raise GeneratorError("Advancement manifest schema_version must be 1.")

    advancements = manifest.get("advancements")
    if not isinstance(advancements, list) or not advancements:
        raise GeneratorError("Advancement manifest advancements must be a non-empty array.")

    required_fields = (
        "key",
        "vanilla_id",
        "helper_id",
        "counter",
        "base_score",
        "title_translate",
        "category",
    )
    seen: dict[str, set[str]] = {
        "key": set(),
        "vanilla_id": set(),
        "helper_id": set(),
        "counter": set(),
    }
    validated: list[dict[str, Any]] = []

    for index, advancement in enumerate(advancements):
        advancement = require_mapping(advancement, f"Advancement manifest entry {index}")
        for field in required_fields:
            if field not in advancement:
                raise GeneratorError(f"Advancement manifest entry {index} is missing {field}.")

        key = require_string(advancement["key"], f"Advancement manifest entry {index} key")
        if not KEY_PATTERN.fullmatch(key):
            raise GeneratorError(f"Advancement key {key!r} must use lowercase letters, digits, and underscores.")

        vanilla_id = require_string(
            advancement["vanilla_id"], f"Advancement manifest entry {key} vanilla_id"
        )
        if not vanilla_id.startswith("minecraft:"):
            raise GeneratorError(f"Advancement {key} vanilla_id must use the minecraft namespace.")

        helper_id = require_string(
            advancement["helper_id"], f"Advancement manifest entry {key} helper_id"
        )
        if not helper_id.startswith("advancement_race:"):
            raise GeneratorError(f"Advancement {key} helper_id must use the advancement_race namespace.")

        counter = require_string(advancement["counter"], f"Advancement manifest entry {key} counter")
        if not counter.startswith("#") or any(character.isspace() for character in counter):
            raise GeneratorError(f"Advancement {key} counter must be a scoreboard fake-player name beginning with #.")

        base_score = advancement["base_score"]
        if isinstance(base_score, bool) or not isinstance(base_score, int) or base_score <= 0:
            raise GeneratorError(f"Advancement {key} base_score must be a positive integer.")

        require_string(
            advancement["title_translate"], f"Advancement manifest entry {key} title_translate"
        )
        require_string(advancement["category"], f"Advancement manifest entry {key} category")

        for field in seen:
            value = advancement[field]
            if value in seen[field]:
                raise GeneratorError(f"Advancement manifest contains duplicate {field}: {value}")
            seen[field].add(value)
        validated.append(advancement)

    return validated


def relative_repo_path(path_text: str, description: str) -> Path:
    relative_path = Path(require_string(path_text, description))
    if relative_path.is_absolute():
        raise GeneratorError(f"{description} must be relative to the repository root.")
    try:
        candidate = (REPO_ROOT / relative_path).resolve()
        candidate.relative_to(REPO_ROOT.resolve())
    except ValueError as error:
        raise GeneratorError(f"{description} must remain inside the repository root.") from error
    return candidate


def helper_output_path(advancement: dict[str, Any]) -> Path:
    namespace, location = advancement["helper_id"].split(":", maxsplit=1)
    if namespace != "advancement_race" or not location or location.startswith("/") or ".." in location.split("/"):
        raise GeneratorError(f"Invalid helper_id for {advancement['key']}: {advancement['helper_id']}")
    return REPO_ROOT / "advancement_race" / "data" / namespace / "advancement" / f"{location}.json"


def reward_output_path(advancement: dict[str, Any]) -> Path:
    return REPO_ROOT / "advancement_race" / "data" / "advancement_race" / "function" / f"reward_{advancement['key']}.mcfunction"


def load_overrides(
    overrides_directory: Path, advancements: list[dict[str, Any]]
) -> dict[str, dict[str, Any]]:
    if not overrides_directory.exists():
        return {}
    if not overrides_directory.is_dir():
        raise GeneratorError(f"Overrides path is not a directory: {overrides_directory}")

    manifest_by_key = {advancement["key"]: advancement for advancement in advancements}
    overrides: dict[str, dict[str, Any]] = {}
    for path in sorted(overrides_directory.glob("*.json")):
        override = require_mapping(read_json(path), f"Override {path}")
        if override.get("schema_version") != 1:
            raise GeneratorError(f"Override {path} schema_version must be 1.")
        key = require_string(override.get("key"), f"Override {path} key")
        if key not in manifest_by_key:
            raise GeneratorError(f"Override {path} refers to unknown manifest key {key!r}.")
        if key in overrides:
            raise GeneratorError(f"Multiple overrides refer to manifest key {key!r}.")
        if override.get("mode") != "manual_helper":
            raise GeneratorError(f"Override {path} mode must be manual_helper.")

        manual_paths = override.get("manual_paths")
        if not isinstance(manual_paths, list) or not manual_paths:
            raise GeneratorError(f"Override {path} manual_paths must be a non-empty array.")
        resolved_paths = [relative_repo_path(item, f"Override {path} manual_paths") for item in manual_paths]
        expected_helper = helper_output_path(manifest_by_key[key])
        if expected_helper not in resolved_paths:
            raise GeneratorError(f"Override {path} must list its helper advancement path.")
        for manual_path in resolved_paths:
            if not manual_path.is_file():
                raise GeneratorError(f"Override {path} references a missing manual file: {manual_path}")

        helper = require_mapping(read_json(expected_helper), f"Manual helper {expected_helper}")
        rewards = require_mapping(helper.get("rewards"), f"Manual helper {expected_helper} rewards")
        expected_reward = f"advancement_race:reward_{key}"
        if rewards.get("function") != expected_reward:
            raise GeneratorError(
                f"Manual helper {expected_helper} must dispatch {expected_reward}."
            )
        overrides[key] = override

    return overrides


def read_vanilla_advancements(
    server_jar: Path, minecraft_version: str, advancements: list[dict[str, Any]]
) -> dict[str, dict[str, Any]]:
    if not server_jar.is_file():
        raise GeneratorError(f"Minecraft server jar does not exist: {server_jar}")

    try:
        with zipfile.ZipFile(server_jar) as outer_jar:
            direct_entry = "data/minecraft/advancement/story/mine_stone.json"
            if direct_entry in outer_jar.namelist():
                return read_advancements_from_zip(outer_jar, advancements)

            bundled_entry = f"META-INF/versions/{minecraft_version}/server-{minecraft_version}.jar"
            try:
                bundled_server = outer_jar.read(bundled_entry)
            except KeyError as error:
                raise GeneratorError(
                    f"Server artifact has neither direct advancement data nor {bundled_entry}."
                ) from error
            with zipfile.ZipFile(io.BytesIO(bundled_server)) as inner_jar:
                return read_advancements_from_zip(inner_jar, advancements)
    except zipfile.BadZipFile as error:
        raise GeneratorError(f"Minecraft server artifact is not a valid jar: {server_jar}") from error


def read_advancements_from_zip(
    archive: zipfile.ZipFile, advancements: list[dict[str, Any]]
) -> dict[str, dict[str, Any]]:
    vanilla_advancements: dict[str, dict[str, Any]] = {}
    for advancement in advancements:
        namespace, location = advancement["vanilla_id"].split(":", maxsplit=1)
        entry_name = f"data/{namespace}/advancement/{location}.json"
        try:
            raw = archive.read(entry_name)
        except KeyError as error:
            raise GeneratorError(
                f"Vanilla advancement {advancement['vanilla_id']} was not found in the server artifact."
            ) from error
        try:
            vanilla = json.loads(raw.decode("utf-8"))
        except (UnicodeDecodeError, json.JSONDecodeError) as error:
            raise GeneratorError(
                f"Vanilla advancement {advancement['vanilla_id']} is not valid UTF-8 JSON."
            ) from error
        vanilla = require_mapping(vanilla, f"Vanilla advancement {advancement['vanilla_id']}")
        for field in ("parent", "criteria", "requirements"):
            if field not in vanilla:
                raise GeneratorError(
                    f"Vanilla advancement {advancement['vanilla_id']} is missing {field}."
                )
        vanilla_advancements[advancement["key"]] = vanilla
    return vanilla_advancements


def render_json(value: dict[str, Any]) -> str:
    return json.dumps(value, ensure_ascii=False, indent=2) + "\n"


def render_helper(advancement: dict[str, Any], vanilla: dict[str, Any]) -> str:
    helper = {
        "parent": vanilla["parent"],
        "criteria": vanilla["criteria"],
        "requirements": vanilla["requirements"],
        "rewards": {"function": f"advancement_race:reward_{advancement['key']}"},
    }
    return render_json(helper)


def render_reward(advancement: dict[str, Any]) -> str:
    return (
        "# Generated by tools/generate_advancements.py; do not edit manually.\n"
        "data modify storage advancement_race:runtime scoring set value "
        f"{{counter:\"{advancement['counter']}\",base_score:{advancement['base_score']},"
        f"advancement:\"{advancement['vanilla_id']}\","
        f"title:\"{advancement['title_translate']}\"}}\n"
        "function advancement_race:scoring/score\n"
    )


def render_counter_initialization(advancements: list[dict[str, Any]]) -> str:
    lines = ["# Generated by tools/generate_advancements.py; do not edit manually."]
    lines.extend(f"scoreboard players add {advancement['counter']} race_state 0" for advancement in advancements)
    return "\n".join(lines) + "\n"


def render_counter_reset(advancements: list[dict[str, Any]]) -> str:
    lines = ["# Generated by tools/generate_advancements.py; do not edit manually."]
    lines.extend(f"scoreboard players set {advancement['counter']} race_state 0" for advancement in advancements)
    return "\n".join(lines) + "\n"


def render_helper_revoke(advancements: list[dict[str, Any]]) -> str:
    lines = ["# Generated by tools/generate_advancements.py; do not edit manually."]
    lines.extend(
        f"advancement revoke @s only {advancement['helper_id']}" for advancement in advancements
    )
    return "\n".join(lines) + "\n"


def expected_outputs(
    advancements: list[dict[str, Any]],
    vanilla_advancements: dict[str, dict[str, Any]],
    overrides: dict[str, dict[str, Any]],
) -> dict[Path, str]:
    outputs: dict[Path, str] = {}
    for advancement in advancements:
        if advancement["key"] not in overrides:
            outputs[helper_output_path(advancement)] = render_helper(
                advancement, vanilla_advancements[advancement["key"]]
            )
        outputs[reward_output_path(advancement)] = render_reward(advancement)

    function_root = REPO_ROOT / "advancement_race" / "data" / "advancement_race" / "function"
    outputs[function_root / "scoring" / "initialize_counters.mcfunction"] = render_counter_initialization(
        advancements
    )
    outputs[function_root / "match" / "reset_counters.mcfunction"] = render_counter_reset(advancements)
    outputs[function_root / "match" / "revoke_helpers.mcfunction"] = render_helper_revoke(advancements)
    return outputs


def write_outputs(outputs: dict[Path, str]) -> None:
    for path, content in outputs.items():
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8", newline="\n")


def check_outputs(outputs: dict[Path, str]) -> list[str]:
    drift: list[str] = []
    for path, expected_content in outputs.items():
        if not path.is_file():
            drift.append(f"missing generated file: {path.relative_to(REPO_ROOT)}")
        elif path.read_text(encoding="utf-8") != expected_content:
            drift.append(f"out-of-date generated file: {path.relative_to(REPO_ROOT)}")
    return drift


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--write", action="store_true", help="Write generated datapack files.")
    mode.add_argument("--check", action="store_true", help="Fail if generated datapack files drift.")
    parser.add_argument(
        "--server-jar",
        type=Path,
        required=True,
        help="Official Minecraft server artifact for the configured version.",
    )
    parser.add_argument("--config", type=Path, default=DEFAULT_CONFIG)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--overrides-dir", type=Path, default=DEFAULT_OVERRIDES)
    return parser.parse_args()


def main() -> int:
    arguments = parse_arguments()
    try:
        config = validate_config(read_json(arguments.config))
        advancements = validate_manifest(read_json(arguments.manifest))
        overrides = load_overrides(arguments.overrides_dir, advancements)
        vanilla_advancements = read_vanilla_advancements(
            arguments.server_jar, config["version"], advancements
        )
        outputs = expected_outputs(advancements, vanilla_advancements, overrides)

        if arguments.write:
            write_outputs(outputs)
            print(f"Wrote {len(outputs)} generated datapack files.")
            return 0

        drift = check_outputs(outputs)
        if drift:
            print("Generated datapack files are out of date:", file=sys.stderr)
            for item in drift:
                print(f"  - {item}", file=sys.stderr)
            return 1
        print(f"Generated datapack files are up to date ({len(outputs)} files).")
        return 0
    except GeneratorError as error:
        print(f"Generator error: {error}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
