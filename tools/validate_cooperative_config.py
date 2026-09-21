#!/usr/bin/env python3
"""Validate the v1.1 Cooperative Border configuration without writing files."""

from __future__ import annotations

import argparse
import importlib.util
import json
import sys
from collections import Counter
from pathlib import Path
from types import ModuleType
from typing import Any


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
EXPECTED_PROFILES = [
    (0, 121, 70000, 400, 120000, 86),
    (1, 121, 68000, 425, 115000, 80),
    (2, 121, 66000, 450, 110000, 74),
    (3, 128, 66000, 475, 110000, 70),
    (4, 128, 64000, 500, 105000, 66),
    (5, 128, 62000, 525, 100000, 62),
    (6, 136, 64000, 550, 105000, 62),
    (7, 136, 62000, 575, 100000, 59),
    (8, 136, 60000, 600, 95000, 55),
    (9, 143, 60000, 600, 100000, 57),
    (10, 143, 58000, 625, 95000, 54),
    (11, 143, 56000, 650, 90000, 52),
    (12, 143, 54000, 675, 85000, 49),
    (13, 143, 52000, 700, 80000, 46),
    (14, 143, 50000, 725, 75000, 44),
    (15, 150, 47500, 725, 85000, 50),
    (16, 150, 45000, 800, 75000, 44),
    (17, 150, 40000, 850, 65000, 40),
    (18, 150, 20000, 1000, 55000, 28),
]
EXPECTED_CHALLENGE_COUNTS = {3: 7, 6: 8, 9: 7, 15: 7}
EXPECTED_DIFFICULTIES = {"easy": 0, "normal": 2, "hard": 3}
EXPECTED_BOSS_PROFILES = {
    "vanilla": (200, 300, 0),
    "veteran": (400, 500, 3),
    "mythic": (650, 800, 6),
}
EXPECTED_INDEPENDENT_MODIFIERS = {
    "no_natural_regeneration": {"challenge_rating": 3},
    "sleepless_nights": {"challenge_rating": 2},
    "death_toll": {"border_delta_per_death": -100, "challenge_rating": 3},
    "failure_tax": {"border_delta_per_failure": -250, "challenge_rating": 3},
    "no_offline_pause": {"challenge_rating": 2},
}
EXPECTED_TIER_VALUES = {
    "T1": (100, 75),
    "T2": (200, 150),
    "T3": (350, 300),
    "T4": (600, 550),
    "T5": (900, 900),
    "T6": (1300, 1300),
}


def load_generator() -> ModuleType:
    sys.dont_write_bytecode = True
    path = REPO_ROOT / "tools" / "generate_cooperative_config.py"
    specification = importlib.util.spec_from_file_location("cooperative_config_generator", path)
    if specification is None or specification.loader is None:
        raise RuntimeError(f"Unable to import generator: {path}")
    module = importlib.util.module_from_spec(specification)
    specification.loader.exec_module(module)
    return module


def load_json(path: Path) -> dict[str, Any]:
    value = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise ValueError("Configuration root must be an object.")
    return value


def validate_rewards(
    config: dict[str, Any], rewards_manifest: dict[str, Any], advancement_manifest: dict[str, Any]
) -> list[str]:
    errors: list[str] = []
    rewards = rewards_manifest.get("rewards")
    advancements = advancement_manifest.get("advancements")
    if rewards_manifest.get("schema_version") != 1 or not isinstance(rewards, list):
        return ["Cooperative rewards manifest must have schema_version 1 and a rewards list"]
    if not isinstance(advancements, list):
        return ["Advancement manifest has no advancements list"]
    expected = [(entry.get("key"), entry.get("vanilla_id")) for entry in advancements]
    actual = [(entry.get("key"), entry.get("vanilla_id")) for entry in rewards if isinstance(entry, dict)]
    if actual != expected:
        errors.append("Cooperative rewards must cover the exact 121-entry advancement manifest in order")
    if len(actual) != 121:
        errors.append(f"Expected 121 Cooperative vanilla rewards, found {len(actual)}")
    if len({key for key, _ in actual}) != len(actual):
        errors.append("Cooperative reward keys must be unique")
    if len({vanilla_id for _, vanilla_id in actual}) != len(actual):
        errors.append("Cooperative reward vanilla IDs must be unique")
    valid_tiers = {entry.get("key") for entry in config.get("reward_tiers", []) if isinstance(entry, dict)}
    for entry in rewards:
        if not isinstance(entry, dict) or entry.get("tier") not in valid_tiers:
            errors.append(f"Invalid Cooperative reward tier entry: {entry!r}")
    return errors


def validate(config: dict[str, Any]) -> list[str]:
    errors: list[str] = []
    if config.get("schema_version") != 1:
        errors.append("schema_version must be 1")

    profiles = config.get("difficulty_profiles")
    if not isinstance(profiles, list):
        errors.append("difficulty_profiles must be a list")
    else:
        actual_profiles = [
            (
                entry.get("level"),
                entry.get("goal_count"),
                entry.get("initial_border"),
                entry.get("shrink_milli_per_second"),
                entry.get("maximum_border"),
                entry.get("budget_hours"),
            )
            for entry in profiles
            if isinstance(entry, dict)
        ]
        if actual_profiles != EXPECTED_PROFILES:
            errors.append("N0-N18 difficulty profiles do not match the approved table")
        for entry in profiles:
            if not isinstance(entry, dict):
                continue
            initial = entry.get("initial_border")
            maximum = entry.get("maximum_border")
            if not isinstance(initial, int) or not isinstance(maximum, int) or initial > maximum:
                errors.append(f"N{entry.get('level')} has invalid initial/maximum Border values")

    tiers = config.get("reward_tiers")
    if not isinstance(tiers, list):
        errors.append("reward_tiers must be a list")
    else:
        actual_tiers = {
            entry.get("key"): (entry.get("team_points"), entry.get("border_delta"))
            for entry in tiers
            if isinstance(entry, dict)
        }
        if actual_tiers != EXPECTED_TIER_VALUES:
            errors.append("Cooperative reward tiers do not match the approved independent values")

    difficulties = config.get("minecraft_difficulties")
    if not isinstance(difficulties, list):
        errors.append("minecraft_difficulties must be a list")
    else:
        actual_difficulties = {
            entry.get("key"): entry.get("challenge_rating")
            for entry in difficulties
            if isinstance(entry, dict)
        }
        if actual_difficulties != EXPECTED_DIFFICULTIES:
            errors.append("Minecraft Difficulty must be Easy CR0, Normal CR2, Hard CR3")

    modifiers = config.get("modifiers")
    bosses = modifiers.get("boss") if isinstance(modifiers, dict) else None
    if not isinstance(bosses, list):
        errors.append("modifiers.boss must be a list")
    else:
        actual_bosses = {
            entry.get("key"): (
                entry.get("ender_dragon_max_health"),
                entry.get("wither_max_health"),
                entry.get("challenge_rating"),
            )
            for entry in bosses
            if isinstance(entry, dict)
        }
        if actual_bosses != EXPECTED_BOSS_PROFILES:
            errors.append("Boss profiles do not match the approved vanilla/veteran/mythic values")

    independent = modifiers.get("independent") if isinstance(modifiers, dict) else None
    if not isinstance(independent, list):
        errors.append("modifiers.independent must be a list")
    else:
        actual_independent = {
            entry.get("key"): {key: value for key, value in entry.items() if key != "key"}
            for entry in independent
            if isinstance(entry, dict)
        }
        if actual_independent != EXPECTED_INDEPENDENT_MODIFIERS:
            errors.append("Independent modifiers do not match the approved CR and Border values")

    challenges = config.get("custom_challenges")
    if not isinstance(challenges, list):
        errors.append("custom_challenges must be a list")
    else:
        keys = [entry.get("key") for entry in challenges if isinstance(entry, dict)]
        if len(challenges) != 29:
            errors.append(f"Expected 29 custom challenges, found {len(challenges)}")
        if len(keys) != len(set(keys)):
            errors.append("Custom challenge keys must be unique")
        counts = Counter(
            entry.get("unlock_level") for entry in challenges if isinstance(entry, dict)
        )
        if dict(counts) != EXPECTED_CHALLENGE_COUNTS:
            errors.append(
                f"Custom challenge pack counts are {dict(counts)}; "
                f"expected {EXPECTED_CHALLENGE_COUNTS}"
            )
        if isinstance(profiles, list):
            for profile in profiles:
                if not isinstance(profile, dict) or not isinstance(profile.get("level"), int):
                    continue
                enabled_count = sum(
                    1
                    for challenge in challenges
                    if isinstance(challenge, dict)
                    and isinstance(challenge.get("unlock_level"), int)
                    and challenge["unlock_level"] <= profile["level"]
                )
                if profile.get("goal_count") != 121 + enabled_count:
                    errors.append(
                        f"N{profile['level']} goal_count must equal 121 vanilla plus "
                        f"{enabled_count} enabled custom challenges"
                    )
        for entry in challenges:
            if not isinstance(entry, dict):
                errors.append("Every custom challenge must be an object")
                continue
            if not isinstance(entry.get("team_points"), int) or entry["team_points"] <= 0:
                errors.append(f"{entry.get('key')}: Team Points must remain a positive integer")
            if not isinstance(entry.get("border_delta"), int) or entry["border_delta"] <= 0:
                errors.append(f"{entry.get('key')}: normal Border reward must be positive")

    n18 = config.get("n18")
    if not isinstance(n18, dict):
        errors.append("n18 must be an object")
    else:
        if n18.get("custom_challenge_border_delta") != -50:
            errors.append("N18 must apply exactly -50 Border per custom challenge")
        if n18.get("preserve_positive_team_points") is not True:
            errors.append("N18 must preserve each custom challenge's positive Team Points")

    modifiers = config.get("modifiers")
    if not isinstance(modifiers, dict):
        errors.append("modifiers must be an object")
    else:
        for group in ("survival", "border", "boss", "independent"):
            entries = modifiers.get(group)
            if not isinstance(entries, list):
                errors.append(f"modifiers.{group} must be a list")
                continue
            keys = [entry.get("key") for entry in entries if isinstance(entry, dict)]
            if len(keys) != len(set(keys)):
                errors.append(f"modifiers.{group} keys must be unique")

    offline = config.get("offline_policy")
    if not isinstance(offline, dict):
        errors.append("offline_policy must be an object")
    elif (
        offline.get("pause_main_clock_and_border_when_no_participant_online") is not True
        or offline.get("fail_active_timed_challenge_when_no_participant_online") is not True
    ):
        errors.append("Approved offline pause/failure policy is not represented")

    return errors


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", type=Path, default=DEFAULT_CONFIG)
    parser.add_argument("--rewards", type=Path, default=DEFAULT_REWARDS)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    return parser.parse_args()


def main() -> int:
    arguments = parse_arguments()
    try:
        config = load_json(arguments.config)
        rewards_manifest = load_json(arguments.rewards)
        advancement_manifest = load_json(ADVANCEMENT_MANIFEST)
        errors = validate(config)
        errors.extend(validate_rewards(config, rewards_manifest, advancement_manifest))
        generator = load_generator()
        generator.validate_flowers_beyond(config)
        expected = generator.render(config, rewards_manifest)
        invalid_path = "data modify storage advancement_race:config cooperative_v11 "
        if any(
            line.startswith(invalid_path)
            and not line.startswith(invalid_path + "set value")
            for line in expected.splitlines()
        ):
            errors.append("Generated runtime config uses an invalid space-separated nested NBT path")
        required_prefix = "data modify storage advancement_race:config cooperative_v11."
        generated_commands = [line for line in expected.splitlines() if line.startswith("data modify ")]
        if not all(
            line.startswith(required_prefix)
            or line.startswith("data modify storage advancement_race:config cooperative_v11 set value")
            for line in generated_commands
        ):
            errors.append("Generated runtime config contains an unexpected target path")
        try:
            actual = arguments.output.read_text(encoding="utf-8")
        except FileNotFoundError:
            actual = ""
        if actual != expected:
            errors.append("Tracked Cooperative runtime configuration is missing or has drifted")
        generated_expected = generator.expected_outputs(config, rewards_manifest, arguments.output)
        generated_actual_paths = generator.managed_generated_paths(arguments.output)
        expected_paths = set(generated_expected)
        missing_paths = expected_paths - generated_actual_paths
        extra_paths = generated_actual_paths - expected_paths
        if missing_paths:
            errors.append(
                "Missing Cooperative generated files: "
                + ", ".join(str(path.relative_to(REPO_ROOT)) for path in sorted(missing_paths))
            )
        if extra_paths:
            errors.append(
                "Unexpected Cooperative generated files: "
                + ", ".join(str(path.relative_to(REPO_ROOT)) for path in sorted(extra_paths))
            )
        for path, content in generated_expected.items():
            if path.exists() and path.read_text(encoding="utf-8") != content:
                errors.append(f"Generated Cooperative file has drifted: {path.relative_to(REPO_ROOT)}")
    except (OSError, ValueError, json.JSONDecodeError, RuntimeError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        return 1

    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1
    print(
        "Cooperative configuration validation passed: "
        "19 levels, 121 vanilla rewards, 29 challenges, 86 Flowers Beyond plants, "
        "N18 -50 Border."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
