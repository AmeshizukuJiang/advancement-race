"""Validate the complete Advancement Race gameplay catalog without writing files."""

from __future__ import annotations

import argparse
import importlib.util
import io
import json
import re
import sys
import zipfile
from pathlib import Path
from types import ModuleType, SimpleNamespace
from typing import Any


REPO_ROOT = Path(__file__).resolve().parent.parent
FUNCTION_ROOT = REPO_ROOT / "advancement_race" / "data" / "advancement_race" / "function"
ADVANCEMENT_ROOT = REPO_ROOT / "advancement_race" / "data" / "advancement_race" / "advancement"
TITLE_MAPPING_PATH = FUNCTION_ROOT / "presentation" / "resolve_advancement_title.mcfunction"
GAMEPLAY_CATEGORIES = {"adventure", "end", "husbandry", "nether", "story"}
EXPECTED_GAMEPLAY_ADVANCEMENTS = 121
EXPECTED_CATEGORY_COUNTS = {
    "story": 15,
    "nether": 22,
    "end": 8,
    "adventure": 46,
    "husbandry": 30,
}
EXPECTED_MANUAL_OVERRIDE_KEYS = {"monster_hunter"}
FUNCTION_REFERENCE = re.compile(r"\bfunction\s+advancement_race:([a-z0-9_/-]+)")


def load_generator() -> ModuleType:
    sys.dont_write_bytecode = True
    generator_path = REPO_ROOT / "tools" / "generate_advancements.py"
    specification = importlib.util.spec_from_file_location("advancement_race_generator", generator_path)
    if specification is None or specification.loader is None:
        raise RuntimeError(f"Unable to import generator: {generator_path}")
    module = importlib.util.module_from_spec(specification)
    specification.loader.exec_module(module)
    return module


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", type=Path, default=REPO_ROOT / "tools" / "generator.config.json")
    parser.add_argument("--manifest", type=Path, default=REPO_ROOT / "tools" / "advancements.manifest.json")
    parser.add_argument("--overrides-dir", type=Path, default=REPO_ROOT / "tools" / "advancement-overrides")
    parser.add_argument("--server-jar", type=Path, help="Use this verified Minecraft server artifact.")
    parser.add_argument("--cache-dir", type=Path, help="Override the external Minecraft artifact cache.")
    parser.add_argument("--offline", action="store_true", help="Require an already cached verified artifact.")
    return parser.parse_args()


def open_vanilla_archive(server_jar: Path, minecraft_version: str) -> zipfile.ZipFile:
    outer = zipfile.ZipFile(server_jar)
    direct_entry = "data/minecraft/advancement/story/mine_stone.json"
    if direct_entry in outer.namelist():
        return outer

    bundled_entry = f"META-INF/versions/{minecraft_version}/server-{minecraft_version}.jar"
    try:
        bundled_server = outer.read(bundled_entry)
    finally:
        outer.close()
    return zipfile.ZipFile(io.BytesIO(bundled_server))


def read_gameplay_catalog(server_jar: Path, minecraft_version: str) -> dict[str, dict[str, Any]]:
    catalog: dict[str, dict[str, Any]] = {}
    with open_vanilla_archive(server_jar, minecraft_version) as archive:
        prefix = "data/minecraft/advancement/"
        for name in archive.namelist():
            if not name.startswith(prefix) or not name.endswith(".json"):
                continue
            location = name[len(prefix) : -len(".json")]
            category = location.split("/", maxsplit=1)[0]
            if category not in GAMEPLAY_CATEGORIES:
                continue
            if location == f"{category}/root":
                continue
            advancement_id = f"minecraft:{location}"
            catalog[advancement_id] = json.loads(archive.read(name).decode("utf-8"))
    return catalog


def validate_manifest_metadata(
    advancements: list[dict[str, Any]], catalog: dict[str, dict[str, Any]]
) -> list[str]:
    errors: list[str] = []
    manifest_ids = {advancement["vanilla_id"] for advancement in advancements}
    catalog_ids = set(catalog)

    missing = sorted(catalog_ids - manifest_ids)
    unexpected = sorted(manifest_ids - catalog_ids)
    if missing:
        errors.append("Manifest is missing vanilla advancements: " + ", ".join(missing))
    if unexpected:
        errors.append("Manifest contains non-gameplay or unknown advancements: " + ", ".join(unexpected))
    if len(catalog_ids) != EXPECTED_GAMEPLAY_ADVANCEMENTS:
        errors.append(
            f"Minecraft 26.2 gameplay catalog has {len(catalog_ids)} entries; "
            f"expected {EXPECTED_GAMEPLAY_ADVANCEMENTS}."
        )

    category_counts = {
        category: sum(1 for advancement in advancements if advancement["category"] == category)
        for category in EXPECTED_CATEGORY_COUNTS
    }
    if category_counts != EXPECTED_CATEGORY_COUNTS:
        errors.append(
            f"Manifest category counts are {category_counts}; expected {EXPECTED_CATEGORY_COUNTS}."
        )

    for advancement in advancements:
        vanilla = catalog.get(advancement["vanilla_id"])
        if vanilla is None:
            continue
        location = advancement["vanilla_id"].split(":", maxsplit=1)[1]
        category = location.split("/", maxsplit=1)[0]
        if advancement["category"] != category:
            errors.append(
                f"{advancement['key']}: category {advancement['category']!r} does not match {category!r}."
            )
        title = vanilla.get("display", {}).get("title")
        if not isinstance(title, dict) or not isinstance(title.get("translate"), str):
            errors.append(f"{advancement['key']}: vanilla advancement has no translatable display title.")
        elif advancement["title_translate"] != title["translate"]:
            errors.append(
                f"{advancement['key']}: title_translate {advancement['title_translate']!r} "
                f"does not match vanilla {title['translate']!r}."
            )
        for field in ("parent", "criteria", "requirements"):
            if field not in vanilla:
                errors.append(f"{advancement['key']}: vanilla source is missing {field}.")
    return errors


def validate_helper_source_integrity(
    generator: ModuleType,
    advancements: list[dict[str, Any]],
    vanilla_advancements: dict[str, dict[str, Any]],
    overrides: dict[str, dict[str, Any]],
) -> list[str]:
    errors: list[str] = []
    for advancement in advancements:
        key = advancement["key"]
        if key in overrides:
            continue
        path = generator.helper_output_path(advancement)
        if not path.is_file():
            errors.append(f"Missing generated helper: {path.relative_to(REPO_ROOT)}")
            continue
        helper = json.loads(path.read_text(encoding="utf-8"))
        vanilla = vanilla_advancements[key]
        expected = {
            "parent": vanilla["parent"],
            "criteria": vanilla["criteria"],
            "requirements": vanilla["requirements"],
            "rewards": {"function": f"advancement_race:reward_{key}"},
        }
        if helper != expected:
            errors.append(f"Generated helper differs from vanilla source: {path.relative_to(REPO_ROOT)}")
    return errors


def validate_generated_path_sets(
    generator: ModuleType, advancements: list[dict[str, Any]]
) -> list[str]:
    errors: list[str] = []
    expected_helpers = {generator.helper_output_path(advancement) for advancement in advancements}
    actual_helpers = set(ADVANCEMENT_ROOT.rglob("*.json"))
    expected_rewards = {generator.reward_output_path(advancement) for advancement in advancements}
    actual_rewards = set(FUNCTION_ROOT.glob("reward_*.mcfunction"))
    expected_index_files = {
        generator.advancement_index_output_path(category)
        for category in generator.ADVANCEMENT_INDEX_CATEGORIES
    }
    actual_index_files = set(
        (FUNCTION_ROOT / "presentation" / "advancement_index").glob("*.mcfunction")
    )
    expected_info_center_files = {
        generator.info_center_advancement_output_path(category)
        for category in generator.ADVANCEMENT_INDEX_CATEGORIES
    }
    actual_info_center_files = set(
        (FUNCTION_ROOT / "presentation" / "info_center_advancements").glob("*.mcfunction")
    )

    for path in sorted(expected_helpers - actual_helpers):
        errors.append(f"Missing helper advancement: {path.relative_to(REPO_ROOT)}")
    for path in sorted(actual_helpers - expected_helpers):
        errors.append(f"Unexpected helper advancement: {path.relative_to(REPO_ROOT)}")
    for path in sorted(expected_rewards - actual_rewards):
        errors.append(f"Missing reward function: {path.relative_to(REPO_ROOT)}")
    for path in sorted(actual_rewards - expected_rewards):
        errors.append(f"Unexpected reward function: {path.relative_to(REPO_ROOT)}")
    for path in sorted(expected_index_files - actual_index_files):
        errors.append(f"Missing generated advancement index: {path.relative_to(REPO_ROOT)}")
    for path in sorted(actual_index_files - expected_index_files):
        errors.append(f"Unexpected generated advancement index: {path.relative_to(REPO_ROOT)}")
    for path in sorted(expected_info_center_files - actual_info_center_files):
        errors.append(f"Missing generated Info Center advancement list: {path.relative_to(REPO_ROOT)}")
    for path in sorted(actual_info_center_files - expected_info_center_files):
        errors.append(f"Unexpected generated Info Center advancement list: {path.relative_to(REPO_ROOT)}")
    return errors


def validate_title_mapping_source_integrity(
    advancements: list[dict[str, Any]], catalog: dict[str, dict[str, Any]]
) -> list[str]:
    if not TITLE_MAPPING_PATH.is_file():
        return [f"Missing generated title mapping: {TITLE_MAPPING_PATH.relative_to(REPO_ROOT)}"]

    actual_lines = {
        line
        for line in TITLE_MAPPING_PATH.read_text(encoding="utf-8").splitlines()
        if line.startswith("execute if data storage advancement_race:runtime ")
    }
    expected_lines: set[str] = set()
    for advancement in advancements:
        vanilla = catalog.get(advancement["vanilla_id"])
        if vanilla is None:
            continue
        title = vanilla.get("display", {}).get("title")
        if not isinstance(title, dict) or not isinstance(title.get("translate"), str):
            continue
        advancement_id_literal = json.dumps(advancement["vanilla_id"], ensure_ascii=False)
        title_literal = json.dumps(title["translate"], ensure_ascii=False)
        expected_lines.add(
            "execute if data storage advancement_race:runtime "
            f"{{presentation:{{advancement:{advancement_id_literal}}}}} "
            "run data modify storage advancement_race:runtime presentation.title_translate "
            f"set value {title_literal}"
        )

    errors: list[str] = []
    for line in sorted(expected_lines - actual_lines):
        errors.append(f"Generated title mapping is missing source entry: {line}")
    for line in sorted(actual_lines - expected_lines):
        errors.append(f"Generated title mapping contains unexpected entry: {line}")
    if len(actual_lines) != EXPECTED_GAMEPLAY_ADVANCEMENTS:
        errors.append(
            f"Generated title mapping has {len(actual_lines)} entries; "
            f"expected {EXPECTED_GAMEPLAY_ADVANCEMENTS}."
        )
    return errors


def validate_json_files() -> list[str]:
    errors: list[str] = []
    paths = [REPO_ROOT / "tools" / "advancements.manifest.json"]
    paths.extend(sorted((REPO_ROOT / "advancement_race").rglob("*.json")))
    paths.extend(sorted((REPO_ROOT / "tools" / "advancement-overrides").glob("*.json")))
    for path in paths:
        try:
            json.loads(path.read_text(encoding="utf-8"))
        except (OSError, UnicodeDecodeError, json.JSONDecodeError) as error:
            errors.append(f"Invalid JSON {path.relative_to(REPO_ROOT)}: {error}")
    return errors


def validate_function_references() -> list[str]:
    errors: list[str] = []
    for source in FUNCTION_ROOT.rglob("*.mcfunction"):
        content = source.read_text(encoding="utf-8")
        for match in FUNCTION_REFERENCE.finditer(content):
            target = FUNCTION_ROOT / f"{match.group(1)}.mcfunction"
            if not target.is_file():
                errors.append(
                    f"{source.relative_to(REPO_ROOT)} references missing function "
                    f"advancement_race:{match.group(1)}"
                )
    return errors


def main() -> int:
    arguments = parse_arguments()
    generator = load_generator()
    try:
        config = generator.validate_config(generator.read_json(arguments.config))
        advancements = generator.validate_manifest(generator.read_json(arguments.manifest))
        resolver_arguments = SimpleNamespace(
            server_jar=arguments.server_jar,
            offline=arguments.offline,
            cache_dir=arguments.cache_dir,
        )
        server_jar = generator.resolve_server_artifact(resolver_arguments, config)
        catalog = read_gameplay_catalog(server_jar, config["version"])
        errors = validate_manifest_metadata(advancements, catalog)
        overrides = generator.load_overrides(arguments.overrides_dir, advancements)
        if set(overrides) != EXPECTED_MANUAL_OVERRIDE_KEYS:
            errors.append(
                "Manual override keys must be exactly: "
                + ", ".join(sorted(EXPECTED_MANUAL_OVERRIDE_KEYS))
                + "; found: "
                + (", ".join(sorted(overrides)) or "none")
            )
        vanilla_advancements = generator.read_vanilla_advancements(server_jar, config["version"], advancements)
        errors.extend(validate_helper_source_integrity(generator, advancements, vanilla_advancements, overrides))
        errors.extend(validate_generated_path_sets(generator, advancements))
        errors.extend(validate_title_mapping_source_integrity(advancements, catalog))
        errors.extend(generator.check_outputs(generator.expected_outputs(advancements, vanilla_advancements, overrides)))
        errors.extend(validate_json_files())
        errors.extend(validate_function_references())
    except generator.GeneratorError as error:
        print(f"Catalog validation failed: {error}", file=sys.stderr)
        return 1
    except (OSError, UnicodeDecodeError, json.JSONDecodeError, zipfile.BadZipFile) as error:
        print(f"Catalog validation failed: {error}", file=sys.stderr)
        return 1

    if errors:
        print("Catalog validation failed:", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1

    print(
        "Catalog validation passed: "
        f"{len(advancements)} gameplay advancements, "
        f"{len(overrides)} manual override, "
        f"{len(catalog)} Mojang 26.2 source entries."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
