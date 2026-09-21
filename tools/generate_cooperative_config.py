#!/usr/bin/env python3
"""Generate the tracked Cooperative Border v1.1 runtime configuration."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path
from typing import Any

sys.dont_write_bytecode = True
from cooperative_ui_generator import render_ui_outputs


REPO_ROOT = Path(__file__).resolve().parent.parent
DEFAULT_CONFIG = REPO_ROOT / "tools" / "cooperative.config.json"
DEFAULT_REWARDS = REPO_ROOT / "tools" / "cooperative_rewards.manifest.json"
ADVANCEMENT_MANIFEST = REPO_ROOT / "tools" / "advancements.manifest.json"
DEFAULT_OUTPUT = (
    REPO_ROOT
    / "advancement_race"
    / "data"
    / "advancement_race"
    / "function"
    / "cooperative"
    / "configure_v11_generated.mcfunction"
)
FLOWERS_ADVANCEMENT_DIR = (
    REPO_ROOT
    / "advancement_race"
    / "data"
    / "advancement_race_coop"
    / "advancement"
    / "challenge"
    / "flowers_beyond"
)
FLOWERS_REWARD_DIR = (
    REPO_ROOT
    / "advancement_race"
    / "data"
    / "advancement_race"
    / "function"
    / "cooperative"
    / "challenges"
    / "flowers_beyond"
    / "generated"
)
FLOWERS_REVOKE_OUTPUT = (
    REPO_ROOT
    / "advancement_race"
    / "data"
    / "advancement_race"
    / "function"
    / "cooperative"
    / "challenges"
    / "flowers_beyond"
    / "revoke_generated.mcfunction"
)
COOPERATIVE_UI_GENERATED_DIR = (
    REPO_ROOT
    / "advancement_race"
    / "data"
    / "advancement_race"
    / "function"
    / "cooperative"
    / "ui_v2"
    / "generated"
)
SAFE_KEY = re.compile(r"^[A-Za-z0-9_.+-]+$")
RESOURCE_LOCATION = re.compile(r"^[a-z0-9_.-]+:[a-z0-9_./-]+$")
FLOWERS_GROUP_COUNTS = {"crops": 19, "saplings_fungi": 15, "flowers": 26, "wild": 26}


class ConfigError(Exception):
    """Invalid source configuration or generated-output drift."""


def read_config(path: Path) -> dict[str, Any]:
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError as error:
        raise ConfigError(f"Missing Cooperative configuration: {path}") from error
    except json.JSONDecodeError as error:
        raise ConfigError(f"Invalid JSON in {path}: {error}") from error
    if not isinstance(value, dict):
        raise ConfigError("Cooperative configuration must be a JSON object.")
    return value


def snbt(value: Any) -> str:
    if value is True:
        return "1b"
    if value is False:
        return "0b"
    if value is None:
        raise ConfigError("null is not supported in runtime Cooperative configuration.")
    if isinstance(value, int):
        return str(value)
    if isinstance(value, float):
        raise ConfigError("Use integer or milli-unit values instead of floating point values.")
    if isinstance(value, str):
        return json.dumps(value, ensure_ascii=False, separators=(",", ":"))
    if isinstance(value, list):
        return "[" + ",".join(snbt(item) for item in value) + "]"
    if isinstance(value, dict):
        members: list[str] = []
        for key, item in value.items():
            rendered_key = key if SAFE_KEY.fullmatch(key) else json.dumps(key, ensure_ascii=False)
            members.append(f"{rendered_key}:{snbt(item)}")
        return "{" + ",".join(members) + "}"
    raise ConfigError(f"Unsupported configuration value: {value!r}")


def resolve_vanilla_rewards(
    config: dict[str, Any], rewards_manifest: dict[str, Any]
) -> list[dict[str, Any]]:
    tiers = {
        tier["key"]: tier
        for tier in config.get("reward_tiers", [])
        if isinstance(tier, dict) and isinstance(tier.get("key"), str)
    }
    overrides = config.get("important_vanilla_border_overrides", {})
    if not isinstance(overrides, dict):
        raise ConfigError("important_vanilla_border_overrides must be an object.")
    rewards = rewards_manifest.get("rewards")
    if rewards_manifest.get("schema_version") != 1 or not isinstance(rewards, list):
        raise ConfigError("Cooperative rewards manifest schema_version must be 1 with a rewards list.")

    resolved: list[dict[str, Any]] = []
    for entry in rewards:
        if not isinstance(entry, dict):
            raise ConfigError("Every Cooperative reward entry must be an object.")
        tier_key = entry.get("tier")
        tier = tiers.get(tier_key)
        if tier is None:
            raise ConfigError(f"Unknown Cooperative reward tier: {tier_key!r}")
        vanilla_id = entry.get("vanilla_id")
        if not isinstance(vanilla_id, str):
            raise ConfigError("Every Cooperative reward entry needs vanilla_id.")
        resolved.append(
            {
                "key": entry.get("key"),
                "vanilla_id": vanilla_id,
                "tier": tier_key,
                "team_points": tier["team_points"],
                "border_delta": overrides.get(vanilla_id, tier["border_delta"]),
            }
        )
    return resolved


def validate_flowers_beyond(config: dict[str, Any]) -> list[dict[str, str]]:
    section = config.get("flowers_beyond")
    if not isinstance(section, dict):
        raise ConfigError("flowers_beyond must be an object.")
    if section.get("duration_seconds") != 180:
        raise ConfigError("Flowers Beyond duration_seconds must be 180.")
    plants = section.get("plants")
    if not isinstance(plants, list) or len(plants) != 86:
        found = len(plants) if isinstance(plants, list) else "non-list"
        raise ConfigError(f"Flowers Beyond must contain exactly 86 plants; found {found}.")

    normalized: list[dict[str, str]] = []
    keys: set[str] = set()
    blocks: set[str] = set()
    group_counts = {group: 0 for group in FLOWERS_GROUP_COUNTS}
    for plant in plants:
        if not isinstance(plant, dict):
            raise ConfigError("Every Flowers Beyond plant must be an object.")
        key = plant.get("key")
        title = plant.get("title")
        group = plant.get("group")
        block = plant.get("block")
        if not isinstance(key, str) or not SAFE_KEY.fullmatch(key):
            raise ConfigError(f"Invalid Flowers Beyond plant key: {key!r}")
        if key in keys:
            raise ConfigError(f"Duplicate Flowers Beyond plant key: {key}")
        if not isinstance(title, str) or not title:
            raise ConfigError(f"Flowers Beyond plant {key} needs a non-empty title.")
        if group not in FLOWERS_GROUP_COUNTS:
            raise ConfigError(f"Flowers Beyond plant {key} has invalid group: {group!r}")
        if not isinstance(block, str) or not RESOURCE_LOCATION.fullmatch(block):
            raise ConfigError(f"Flowers Beyond plant {key} has invalid block ID: {block!r}")
        if block in blocks:
            raise ConfigError(f"Duplicate Flowers Beyond block ID: {block}")
        keys.add(key)
        blocks.add(block)
        group_counts[group] += 1
        normalized.append({"key": key, "title": title, "group": group, "block": block})
    if group_counts != FLOWERS_GROUP_COUNTS:
        raise ConfigError(
            f"Flowers Beyond group counts are {group_counts}; expected {FLOWERS_GROUP_COUNTS}."
        )
    return normalized


def render_flower_advancement(plant: dict[str, str]) -> str:
    value = {
        "criteria": {
            "placed": {
                "trigger": "minecraft:placed_block",
                "conditions": {
                    "location": [
                        {
                            "condition": "minecraft:block_state_property",
                            "block": plant["block"],
                        }
                    ]
                },
            }
        },
        "requirements": [["placed"]],
        "rewards": {
            "function": (
                "advancement_race:cooperative/challenges/flowers_beyond/generated/"
                + plant["key"]
            )
        },
    }
    return json.dumps(value, ensure_ascii=False, separators=(",", ":")) + "\n"


def render_flower_reward(plant: dict[str, str]) -> str:
    key = plant["key"]
    group = plant["group"]
    title = plant["title"]
    advancement = f"advancement_race_coop:challenge/flowers_beyond/{key}"
    challenge = "cooperative.challenges.flowers_beyond"
    actionbar = json.dumps(
        [
            {"text": f"Flowers Beyond · {title} · ", "color": "aqua"},
            {
                "score": {"name": "#flowers_total", "objective": "race_state"},
                "color": "yellow",
            },
            {"text": "/86", "color": "gray"},
        ],
        ensure_ascii=False,
        separators=(",", ":"),
    )
    lines = [
        f"advancement revoke @s only {advancement}",
        "scoreboard players set #flowers_new race_state 0",
        (
            "execute if data storage advancement_race:match "
            "{status:\"active\",mode:\"cooperative_border\",cooperative:{challenges:"
            "{flowers_beyond:{status:\"active\"}}}} "
            "if score @s race_participant matches 0.. "
            f"unless data storage advancement_race:match {challenge}.placed.{key} "
            "run scoreboard players set #flowers_new race_state 1"
        ),
        (
            "execute if score #flowers_new race_state matches 1 run data modify storage "
            f"advancement_race:match {challenge}.placed.{key} set value 1b"
        ),
        (
            "execute if score #flowers_new race_state matches 1 store result score "
            f"#flowers_total race_state run data get storage advancement_race:match {challenge}.completed_count"
        ),
        "execute if score #flowers_new race_state matches 1 run scoreboard players add #flowers_total race_state 1",
        (
            "execute if score #flowers_new race_state matches 1 store result storage "
            f"advancement_race:match {challenge}.completed_count int 1 run scoreboard players get "
            "#flowers_total race_state"
        ),
        (
            "execute if score #flowers_new race_state matches 1 store result score "
            f"#flowers_group race_state run data get storage advancement_race:match {challenge}.{group}_count"
        ),
        "execute if score #flowers_new race_state matches 1 run scoreboard players add #flowers_group race_state 1",
        (
            "execute if score #flowers_new race_state matches 1 store result storage "
            f"advancement_race:match {challenge}.{group}_count int 1 run scoreboard players get "
            "#flowers_group race_state"
        ),
        (
            "execute if score #flowers_new race_state matches 1 run title "
            f"@a[scores={{race_participant=0..}}] actionbar {actionbar}"
        ),
        (
            "execute if score #flowers_new race_state matches 1 if score #flowers_total "
            "race_state matches 86 run function "
            "advancement_race:cooperative/challenges/flowers_beyond/complete"
        ),
    ]
    return "\n".join(lines) + "\n"


def render_flower_show_prepare(plants: list[dict[str, str]]) -> str:
    lines = ["# Generated by tools/generate_cooperative_config.py. Do not edit by hand."]
    for plant in plants:
        key = plant["key"]
        lines.append(
            f'data modify storage advancement_race:runtime cooperative_ui_list.{key}_marker set value "•"'
        )
        lines.append(
            f'data modify storage advancement_race:runtime cooperative_ui_list.{key}_color set value "#555555"'
        )
    return "\n".join(lines) + "\n"


def render_flower_show_active(plants: list[dict[str, str]]) -> str:
    lines = ["# Generated by tools/generate_cooperative_config.py. Do not edit by hand."]
    challenge = "cooperative.challenges.flowers_beyond"
    for plant in plants:
        key = plant["key"]
        lines.append(
            f'data modify storage advancement_race:runtime cooperative_ui_list.{key}_marker set value "✗"'
        )
        lines.append(
            f'data modify storage advancement_race:runtime cooperative_ui_list.{key}_color set value "#9B2226"'
        )
        lines.append(
            f'execute if data storage advancement_race:match {challenge}.placed.{key} run data modify storage advancement_race:runtime cooperative_ui_list.{key}_marker set value "✓"'
        )
        lines.append(
            f'execute if data storage advancement_race:match {challenge}.placed.{key} run data modify storage advancement_race:runtime cooperative_ui_list.{key}_color set value "#2E6B35"'
        )
    return "\n".join(lines) + "\n"


def render_flower_show_emit(plants: list[dict[str, str]]) -> str:
    by_group: dict[str, list[dict[str, str]]] = {
        group: [plant for plant in plants if plant["group"] == group]
        for group in FLOWERS_GROUP_COUNTS
    }
    group_titles = {
        "crops": "Crops",
        "saplings_fungi": "Saplings & Fungi",
        "flowers": "Flowers",
        "wild": "Wild Plants",
    }
    lines = [
        'tellraw @s [{"text":"Flowers Beyond · Required Plants","color":"#8A5A00","bold":true},{"text":" · 86 total","color":"#555555","bold":false}]'
    ]
    for group, entries in by_group.items():
        for offset in range(0, len(entries), 9):
            chunk = entries[offset : offset + 9]
            components: list[dict[str, Any]] = []
            if offset == 0:
                components.append(
                    {
                        "text": group_titles[group] + "\n",
                        "color": "#8A6500",
                        "bold": True,
                    }
                )
            for index, plant in enumerate(chunk):
                suffix = "\n" if (index + 1) % 3 == 0 else "  "
                components.append(
                    {
                        "text": f"$({plant['key']}_marker) {plant['title']}{suffix}",
                        "color": f"$({plant['key']}_color)",
                        "bold": False,
                    }
                )
            command = "tellraw @s " + json.dumps(
                components, ensure_ascii=False, separators=(",", ":")
            )
            lines.append("$" + command)
    return "\n".join(lines) + "\n"


def expected_outputs(
    config: dict[str, Any], rewards_manifest: dict[str, Any], output: Path = DEFAULT_OUTPUT
) -> dict[Path, str]:
    plants = validate_flowers_beyond(config)
    outputs = {output: render(config, rewards_manifest)}
    revoke_lines = [
        "# Generated by tools/generate_cooperative_config.py. Do not edit by hand."
    ]
    for plant in plants:
        key = plant["key"]
        outputs[FLOWERS_ADVANCEMENT_DIR / f"{key}.json"] = render_flower_advancement(plant)
        outputs[FLOWERS_REWARD_DIR / f"{key}.mcfunction"] = render_flower_reward(plant)
        revoke_lines.append(
            f"advancement revoke @s only advancement_race_coop:challenge/flowers_beyond/{key}"
        )
    outputs[FLOWERS_REWARD_DIR / "show_list_prepare_generated.mcfunction"] = (
        render_flower_show_prepare(plants)
    )
    outputs[FLOWERS_REWARD_DIR / "show_list_active_generated.mcfunction"] = (
        render_flower_show_active(plants)
    )
    outputs[FLOWERS_REWARD_DIR / "show_list_emit_generated.mcfunction"] = (
        render_flower_show_emit(plants)
    )
    outputs[FLOWERS_REVOKE_OUTPUT] = "\n".join(revoke_lines) + "\n"
    try:
        outputs.update(
            render_ui_outputs(
                config,
                resolve_vanilla_rewards(config, rewards_manifest),
                read_config(ADVANCEMENT_MANIFEST),
                COOPERATIVE_UI_GENERATED_DIR,
            )
        )
    except ValueError as error:
        raise ConfigError(str(error)) from error
    return outputs


def managed_generated_paths(output: Path = DEFAULT_OUTPUT) -> set[Path]:
    paths: set[Path] = set()
    if output.exists():
        paths.add(output)
    if FLOWERS_REVOKE_OUTPUT.exists():
        paths.add(FLOWERS_REVOKE_OUTPUT)
    if FLOWERS_ADVANCEMENT_DIR.exists():
        paths.update(FLOWERS_ADVANCEMENT_DIR.glob("*.json"))
    if FLOWERS_REWARD_DIR.exists():
        paths.update(FLOWERS_REWARD_DIR.glob("*.mcfunction"))
    if COOPERATIVE_UI_GENERATED_DIR.exists():
        paths.update(path for path in COOPERATIVE_UI_GENERATED_DIR.iterdir() if path.is_file())
    return paths


def render(config: dict[str, Any], rewards_manifest: dict[str, Any]) -> str:
    required = (
        "schema_version",
        "difficulty_profiles",
        "reward_tiers",
        "important_vanilla_border_overrides",
        "minecraft_difficulties",
        "modifiers",
        "custom_challenges",
        "flowers_beyond",
        "n18",
        "offline_policy",
    )
    missing = [key for key in required if key not in config]
    if missing:
        raise ConfigError("Missing required configuration sections: " + ", ".join(missing))

    target = "storage advancement_race:config"
    root_path = "cooperative_v11"
    lines = [
        "# Generated by tools/generate_cooperative_config.py. Do not edit by hand.",
        f"data modify {target} {root_path} set value {{schema_version:{snbt(config['schema_version'])}}}",
        f"data modify {target} {root_path}.difficulty_profiles set value []",
    ]
    for profile in config["difficulty_profiles"]:
        lines.append(
            f"data modify {target} {root_path}.difficulty_profiles append value {snbt(profile)}"
        )

    lines.append(f"data modify {target} {root_path}.reward_tiers set value []")
    for tier in config["reward_tiers"]:
        lines.append(f"data modify {target} {root_path}.reward_tiers append value {snbt(tier)}")

    lines.append(
        f"data modify {target} {root_path}.important_vanilla_border_overrides set value "
        f"{snbt(config['important_vanilla_border_overrides'])}"
    )
    lines.append(f"data modify {target} {root_path}.vanilla_rewards set value []")
    for reward in resolve_vanilla_rewards(config, rewards_manifest):
        lines.append(f"data modify {target} {root_path}.vanilla_rewards append value {snbt(reward)}")
    lines.append(
        f"data modify {target} {root_path}.minecraft_difficulties set value "
        f"{snbt(config['minecraft_difficulties'])}"
    )
    lines.append(f"data modify {target} {root_path}.modifiers set value {snbt(config['modifiers'])}")
    lines.append(f"data modify {target} {root_path}.custom_challenges set value []")
    for challenge in config["custom_challenges"]:
        lines.append(
            f"data modify {target} {root_path}.custom_challenges append value {snbt(challenge)}"
        )
    lines.append(f"data modify {target} {root_path}.enabled_challenge_ids_by_level set value []")
    for level in range(19):
        enabled_ids = [
            challenge["key"]
            for challenge in config["custom_challenges"]
            if challenge["unlock_level"] <= level
        ]
        lines.append(
            f"data modify {target} {root_path}.enabled_challenge_ids_by_level append value "
            f"{snbt({'level': level, 'ids': enabled_ids})}"
        )
    lines.append(f"data modify {target} {root_path}.n18 set value {snbt(config['n18'])}")
    lines.append(
        f"data modify {target} {root_path}.offline_policy set value "
        f"{snbt(config['offline_policy'])}"
    )
    return "\n".join(lines) + "\n"


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", type=Path, default=DEFAULT_CONFIG)
    parser.add_argument("--rewards", type=Path, default=DEFAULT_REWARDS)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--write", action="store_true", help="Write the generated runtime function.")
    mode.add_argument("--check", action="store_true", help="Fail if the tracked output has drifted.")
    return parser.parse_args()


def main() -> int:
    arguments = parse_arguments()
    try:
        expected = expected_outputs(
            read_config(arguments.config), read_config(arguments.rewards), arguments.output
        )
        if arguments.write:
            for path, content in expected.items():
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(content, encoding="utf-8", newline="\n")
            for path in managed_generated_paths(arguments.output) - set(expected):
                path.unlink()
            print(f"Wrote {len(expected)} Cooperative generated files.")
            return 0

        actual_paths = managed_generated_paths(arguments.output)
        expected_paths = set(expected)
        missing = expected_paths - actual_paths
        extra = actual_paths - expected_paths
        if missing:
            raise ConfigError(
                "Missing generated Cooperative files: "
                + ", ".join(str(path.relative_to(REPO_ROOT)) for path in sorted(missing))
            )
        if extra:
            raise ConfigError(
                "Unexpected generated Cooperative files: "
                + ", ".join(str(path.relative_to(REPO_ROOT)) for path in sorted(extra))
            )
        drifted = [
            path
            for path, content in expected.items()
            if path.read_text(encoding="utf-8") != content
        ]
        if drifted:
            raise ConfigError(
                "Generated Cooperative files have drifted: "
                + ", ".join(str(path.relative_to(REPO_ROOT)) for path in drifted)
                + ". Run tools/generate_cooperative_config.py --write."
            )
        print(f"Cooperative configuration generation check passed ({len(expected)} files).")
        return 0
    except ConfigError as error:
        print(f"ERROR: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
