#!/usr/bin/env python3
"""Render the generated Cooperative Info Center index and detail pages."""

from __future__ import annotations

import json
from collections import defaultdict
from pathlib import Path
from typing import Any


CATEGORY_ORDER = ("story", "nether", "end", "adventure", "husbandry")
CATEGORY_TITLES = {
    "story": "Story",
    "nether": "Nether",
    "end": "The End",
    "adventure": "Adventure",
    "husbandry": "Husbandry",
}
ENTRIES_PER_PAGE = 5

# Runtime storage names differ for the two original prototype challenges.
CHALLENGE_PATHS = {
    "calamity_relay": "relay",
    "four_realm_supply_line": "supply",
    "calamity_relay_ii": "relay_ii",
}

CHALLENGE_RULES = {
    "splendid_as_summer_flowers": "Die from an exploding firework rocket.",
    "injustice_in_june": "Pick up a powder snow bucket while in a desert.",
    "end_fishing": "Catch an item with a fishing rod in the End.",
    "fire_and_ice": "Be burning and freezing at the same instant.",
    "calamity_relay": "Defeat the six listed hostile mobs before the timer expires.",
    "four_realm_supply_line": "Submit the required iron, gold, diamonds, and obsidian. Items are consumed.",
    "eternal_slumber": "During one attempt, trigger bad-respawn explosions in the Overworld, Nether, and End.",
    "ecological_restoration": "Plant all ten required crops before the timer expires.",
    "something_is_wrong": "Barter with a Piglin in a fortress and kill a Blaze in a bastion during one timed attempt.",
    "sleep_above_clouds": "Successfully sleep at the required high altitude.",
    "out_of_climate": "Complete the required cold-biome Strider interaction.",
    "calamity_relay_ii": "Defeat the six advanced hostile mobs before the timer expires.",
    "automation_is_not_magic": "Submit the four required industrial supplies. Items are consumed.",
    "underwater_furnace": "Operate a furnace at the required underwater location.",
    "into_the_nightmare": "Complete the required Phantom encounter in the Deep Dark.",
    "ascend_the_soul": "Make a Shulker in the Nether levitate a Wither Skeleton.",
    "end_trading_post": "Complete a Villager trade in the End.",
    "alien_froglight": "Create a froglight from a small Magma Cube in the End.",
    "three_realm_finale": "Within five minutes, defeat the bound Overworld Warden, Nether Wither, and Ender Dragon.",
    "museum_closing_check": "The online team must simultaneously hold all seven required museum items.",
    "still_not_fast_enough": "The same bound player must die to the World Border in all three dimensions within 15 minutes.",
    "visitor_from_beyond": "Complete the required cross-dimensional visitor objective.",
    "raid_silent_hill": "Win a raid inside an Ancient City.",
    "three_realm_merchant": "Trade with the same bound Villager in the Overworld, Nether, and End.",
    "jailer_unemployed": "Bind a nearby Warden and Wither, then have the Warden land the killing blow.",
    "shoot_down_the_moon": "Kill a newly respawned Ender Dragon within five seconds of its return.",
    "rekindle_old_dream": "Damage the bound Ender Dragon with a bed explosion in the End.",
    "foreign_crusade": "Within ten minutes, defeat the bound End Wither, Nether Evoker, and Overworld Shulker.",
    "flowers_beyond": "Within three minutes, place all 86 listed crops, saplings, flowers, and wild plants.",
}

# action field, label; None means automatic detection.
CHALLENGE_ACTIONS: dict[str, tuple[str, str] | str | None] = {
    "calamity_relay": ("relay_action", "Start / Restart"),
    "four_realm_supply_line": "supply_manage",
    "eternal_slumber": ("eternal_slumber_action", "Start / Restart"),
    "ecological_restoration": ("ecological_action", "Start / Restart"),
    "something_is_wrong": ("something_wrong_action", "Start / Restart"),
    "calamity_relay_ii": ("relay_ii_action", "Start / Restart"),
    "automation_is_not_magic": "automation_manage",
    "three_realm_finale": ("three_realm_finale_action", "Bind / Start"),
    "museum_closing_check": ("museum_check_action", "Check Collection"),
    "still_not_fast_enough": ("still_not_fast_enough_action", "Start / Restart"),
    "three_realm_merchant": ("three_realm_merchant_action", "Bind / Restart"),
    "jailer_unemployed": ("jailer_unemployed_action", "Bind / Restart"),
    "shoot_down_the_moon": ("shoot_down_the_moon_action", "Arm / Retry"),
    "rekindle_old_dream": ("rekindle_old_dream_action", "Bind / Restart"),
    "foreign_crusade": ("foreign_crusade_action", "Rebind / Restart"),
    "flowers_beyond": ("flowers_beyond_action", "Start / Restart"),
}

CHALLENGE_LIST_ACTIONS = {
    "ecological_restoration": "ecological_show_list_action",
    "flowers_beyond": "flowers_beyond_show_list_action",
}


def compact(value: Any) -> str:
    return json.dumps(value, ensure_ascii=False, separators=(",", ":"))


def page(root: dict[str, Any]) -> str:
    return (
        "data modify storage advancement_race:runtime info_center.pages append value "
        + "{raw:"
        + compact(root)
        + "}"
    )


def link(text: str, target: int, *, color: str = "#006B73") -> dict[str, Any]:
    return {
        "text": text,
        "color": color,
        "bold": True,
        "underlined": True,
        "click_event": {"action": "change_page", "page": target},
    }


def refresh(text: str = "  [Refresh]\n") -> dict[str, Any]:
    return {
        "text": text,
        "color": "#8A6500",
        "bold": True,
        "underlined": True,
        "click_event": {"action": "run_command", "command": "/trigger race_menu"},
    }


def nav(index_title: str, index_page: int) -> tuple[dict[str, Any], list[dict[str, Any]]]:
    return link("[⌂ Info Center]", 1), [link(f"  [{index_title}]\n", index_page)]


def challenge_runtime_path(key: str) -> str:
    return CHALLENGE_PATHS.get(key, key)


def split_pages(items: list[dict[str, Any]]) -> list[list[dict[str, Any]]]:
    return [items[index : index + ENTRIES_PER_PAGE] for index in range(0, len(items), ENTRIES_PER_PAGE)]


def render_ui_outputs(
    config: dict[str, Any],
    rewards: list[dict[str, Any]],
    advancement_manifest: dict[str, Any],
    output_dir: Path,
) -> dict[Path, str]:
    advancements = advancement_manifest.get("advancements")
    challenges = config.get("custom_challenges")
    if not isinstance(advancements, list) or len(advancements) != 121:
        raise ValueError("Cooperative UI generation requires the exact 121-entry advancement manifest.")
    if not isinstance(challenges, list) or len(challenges) != 29:
        raise ValueError("Cooperative UI generation requires the exact 29-entry challenge catalog.")
    reward_by_id = {entry["vanilla_id"]: entry for entry in rewards}

    by_category: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for advancement in advancements:
        category = advancement.get("category")
        vanilla_id = advancement.get("vanilla_id")
        reward = reward_by_id.get(vanilla_id)
        if category not in CATEGORY_ORDER or reward is None:
            raise ValueError(f"Invalid Cooperative UI advancement metadata: {advancement!r}")
        by_category[category].append({**advancement, **reward})

    # Pages are one-based for click events and zero-based for NBT list paths.
    next_page = 6
    category_page_numbers: dict[str, list[int]] = {}
    category_chunks: dict[str, list[list[dict[str, Any]]]] = {}
    for category in CATEGORY_ORDER:
        chunks = split_pages(by_category[category])
        category_chunks[category] = chunks
        category_page_numbers[category] = list(range(next_page, next_page + len(chunks)))
        next_page += len(chunks)

    tier_chunks: dict[int, list[list[dict[str, Any]]]] = {}
    tier_page_numbers: dict[int, list[int]] = {}
    for tier in (3, 6, 9, 15):
        tier_items = [entry for entry in challenges if entry["unlock_level"] == tier]
        chunks = split_pages(tier_items)
        tier_chunks[tier] = chunks
        tier_page_numbers[tier] = list(range(next_page, next_page + len(chunks)))
        next_page += len(chunks)

    detail_pages: dict[str, int] = {}
    for challenge in challenges:
        detail_pages[challenge["key"]] = next_page
        next_page += 1
    supply_manage_page = next_page
    automation_manage_page = next_page + 1

    lines = ["# Generated by tools/generate_cooperative_config.py. Do not edit by hand."]
    home = {
        "text": "Advancement Race\n",
        "color": "#8A5A00",
        "bold": True,
        "extra": [
            {"text": "Cooperative Info Center\n", "color": "#2E6B35", "bold": False},
            {"text": "Match #$(match_id) · $(n_label) · CR $(challenge_rating)\n", "color": "#555555", "bold": False},
            {"text": "Points $(team_points) · Border $(border_size)\n", "color": "#8A6500", "bold": False},
            {"text": "Shrink $(shrink_whole).$(shrink_tenths)/s · Time $(duration_minutes)m\n", "color": "#555555", "bold": False},
            {"text": "Vanilla $(vanilla_completed)/121 · Challenges $(challenge_completed)/$(required_custom)\n\n", "color": "#2E6B35", "bold": False},
            link("[Vanilla Index]", 2),
            link("\n[Challenge Index]", 3),
            link(" [Rules]", 4),
            {"text": "\n[Previous Races]", "color": "#006B73", "bold": True, "underlined": True, "click_event": {"action": "run_command", "command": "/trigger race_menu set 9"}},
            refresh("\n[Refresh]"),
            {"text": "\n\nDANGER ZONE\n", "color": "#9B2226", "bold": True},
            link("[VOTE TO END]", 5, color="#9B2226"),
        ],
    }
    lines.append(page(home))

    vanilla_extra: list[dict[str, Any]] = [refresh(), {"text": "Vanilla Index\n", "color": "#8A5A00", "bold": True}, {"text": "Team completion\n\n", "color": "#555555", "bold": False}]
    for index, category in enumerate(CATEGORY_ORDER):
        prefix = "" if index == 0 else "\n"
        vanilla_extra.append(link(f"{prefix}{CATEGORY_TITLES[category]}  $(ui_v2_{category}_completed) / {len(by_category[category])}", category_page_numbers[category][0]))
    lines.append(page({"text": "[⌂ Info Center]", "color": "#006B73", "bold": True, "underlined": True, "click_event": {"action": "change_page", "page": 1}, "extra": vanilla_extra}))

    challenge_extra: list[dict[str, Any]] = [refresh(), {"text": "Challenge Index\n", "color": "#8A5A00", "bold": True}, {"text": "Cumulative challenge packs\n\n", "color": "#555555", "bold": False}]
    for index, tier in enumerate((3, 6, 9, 15)):
        total = sum(1 for entry in challenges if entry["unlock_level"] == tier)
        prefix = "" if index == 0 else "\n"
        challenge_extra.append(link(f"{prefix}N{tier}  $(ui_v2_n{tier}_completed) / {total}", tier_page_numbers[tier][0]))
    lines.append(page({"text": "[⌂ Info Center]", "color": "#006B73", "bold": True, "underlined": True, "click_event": {"action": "change_page", "page": 1}, "extra": challenge_extra}))

    rules_extra = [refresh(), {"text": "Cooperative Rules\n", "color": "#8A5A00", "bold": True}, {"text": "$(n_label) · $(game_difficulty_label) · CR $(challenge_rating)\nRisk: $(risk_label)\nGoals: $(goal_count)\n\nSurvival: $(survival_label)\nBosses: $(boss_label)\nFaster/Tight/Cap: $(faster_label)/$(tight_label)/$(ceiling_label)\nNo Regen: $(regen_label) · Sleep: $(sleep_label)\nDeath Toll: $(death_toll_label)\nFailure Tax: $(failure_tax_label)\nOffline Clock: $(offline_label)", "color": "#555555", "bold": False}]
    lines.append(page({"text": "[⌂ Info Center]", "color": "#006B73", "bold": True, "underlined": True, "click_event": {"action": "change_page", "page": 1}, "extra": rules_extra}))
    vote_extra = [{"text": "\nEnd Match Vote\n\n", "color": "#9B2226", "bold": True}, {"text": "Votes: $(vote_count) / $(required_votes) required\n\n", "color": "#2B2B2B", "bold": False}, {"text": "[Confirm Vote]", "color": "#9B2226", "bold": True, "underlined": True, "click_event": {"action": "run_command", "command": "/trigger race_menu set $(vote_action_code)"}}, link("\n[Cancel]", 1)]
    lines.append(page({"text": "[⌂ Info Center]", "color": "#006B73", "bold": True, "underlined": True, "click_event": {"action": "change_page", "page": 1}, "extra": vote_extra}))

    for category in CATEGORY_ORDER:
        chunks = category_chunks[category]
        numbers = category_page_numbers[category]
        for part, number in enumerate(numbers):
            root, extra = nav("Vanilla Index", 2)
            extra.append({"text": f"{CATEGORY_TITLES[category]} · {part + 1}/{len(chunks)}\n", "color": "#8A5A00", "bold": True})
            if part:
                extra.append(link("[← Previous]", numbers[part - 1]))
            if part + 1 < len(numbers):
                extra.append(link("  [Next →]", numbers[part + 1]))
            lines.append(page({**root, "extra": extra}))

    for tier in (3, 6, 9, 15):
        chunks = tier_chunks[tier]
        numbers = tier_page_numbers[tier]
        for part, number in enumerate(numbers):
            root, extra = nav("Challenge Index", 3)
            extra.append({"text": f"N{tier} Challenges · {part + 1}/{len(chunks)}\n", "color": "#8A5A00", "bold": True})
            if part:
                extra.append(link("[← Previous]", numbers[part - 1]))
            if part + 1 < len(numbers):
                extra.append(link("  [Next →]", numbers[part + 1]))
            lines.append(page({**root, "extra": extra}))

    for challenge in challenges:
        key = challenge["key"]
        action = CHALLENGE_ACTIONS.get(key)
        root, extra = nav("Challenge Index", 3)
        extra.extend([
            refresh(),
            {"text": f"{challenge['title']}\n", "color": "#8A5A00", "bold": True},
            {"text": f"Status: $(ui_challenge_{key}_status)\n\n", "color": "#555555", "bold": False},
            {"text": "[Rules]", "color": "#006B73", "bold": True, "underlined": True, "hover_event": {"action": "show_text", "value": {"text": f"{CHALLENGE_RULES[key]}\n\nTeam Points: +{challenge['team_points']}\nBorder: +{challenge['border_delta']}\nN18 Border: -50", "color": "#555555"}}},
        ])
        if action == "supply_manage":
            extra.append(link("  [Manage Submissions]", supply_manage_page, color="#2E6B35"))
        elif action == "automation_manage":
            extra.append(link("  [Manage Submissions]", automation_manage_page, color="#2E6B35"))
        elif isinstance(action, tuple):
            field, label = action
            extra.append({"text": f"  [{label}]", "color": "#2E6B35", "bold": True, "underlined": True, "click_event": {"action": "run_command", "command": f"/trigger race_menu set $({field})"}})
        else:
            extra.append({"text": "  [Automatic Detection]", "color": "#555555", "bold": False})
        list_action = CHALLENGE_LIST_ACTIONS.get(key)
        if list_action:
            extra.append({"text": "\n[Show List]", "color": "#006B73", "bold": True, "underlined": True, "click_event": {"action": "run_command", "command": f"/trigger race_menu set $({list_action})"}})
        lines.append(page({**root, "extra": extra}))

    supply_key_page = detail_pages["four_realm_supply_line"]
    root, extra = nav("四线补给", supply_key_page)
    extra.extend([refresh(), {"text": "Manage Submissions\n", "color": "#8A5A00", "bold": True}])
    for label, value, target, action_field in (
        ("Iron", "supply_iron", "supply_iron_target", "supply_iron_action"),
        ("Gold", "supply_gold", "supply_gold_target", "supply_gold_action"),
        ("Diamond", "supply_diamond", "supply_diamond_target", "supply_diamond_action"),
        ("Obsidian", "supply_obsidian", "supply_obsidian_target", "supply_obsidian_action"),
    ):
        extra.append({"text": f"{label} $({value})/$({target}) ", "color": "#555555", "bold": False})
        extra.append({"text": "[Submit]\n", "color": "#2E6B35", "underlined": True, "click_event": {"action": "run_command", "command": f"/trigger race_menu set $({action_field})"}})
    lines.append(page({**root, "extra": extra}))

    automation_key_page = detail_pages["automation_is_not_magic"]
    root, extra = nav("自动化不是魔法", automation_key_page)
    extra.extend([refresh(), {"text": "Manage Submissions\n", "color": "#8A5A00", "bold": True}])
    for label, value, target, action_field in (
        ("Iron", "automation_iron", "automation_iron_target", "automation_iron_action"),
        ("Kelp", "automation_dried_kelp", "automation_dried_kelp_target", "automation_dried_kelp_action"),
        ("Fireworks", "automation_fireworks", "automation_fireworks_target", "automation_fireworks_action"),
        ("Honey", "automation_honey", "automation_honey_target", "automation_honey_action"),
    ):
        extra.append({"text": f"{label} $({value})/$({target}) ", "color": "#555555", "bold": False})
        extra.append({"text": "[Submit]\n", "color": "#2E6B35", "underlined": True, "click_event": {"action": "run_command", "command": f"/trigger race_menu set $({action_field})"}})
    lines.append(page({**root, "extra": extra}))

    outputs: dict[Path, str] = {
        output_dir / "build_pages_generated.mcfunction": "\n".join(
            "$" + line if "$(" in line else line for line in lines
        )
        + "\n"
    }

    counts = ["# Generated by tools/generate_cooperative_config.py. Do not edit by hand."]
    for category in CATEGORY_ORDER:
        score = f"#coop_ui_v2_{category}"
        counts.append(f"scoreboard players set {score} race_state 0")
        for advancement in by_category[category]:
            counts.append(f"execute if data storage advancement_race:match cooperative.completed[{{id:\"{advancement['vanilla_id']}\"}}] run scoreboard players add {score} race_state 1")
        counts.append(f"execute store result storage advancement_race:runtime info_center.ui_v2_{category}_completed int 1 run scoreboard players get {score} race_state")
    for tier in (3, 6, 9, 15):
        score = f"#coop_ui_v2_n{tier}"
        counts.append(f"scoreboard players set {score} race_state 0")
        for challenge in challenges:
            if challenge["unlock_level"] == tier:
                counts.append(f"execute if data storage advancement_race:match cooperative.challenges.{challenge_runtime_path(challenge['key'])}{{status:\"completed\"}} run scoreboard players add {score} race_state 1")
        counts.append(f"execute store result storage advancement_race:runtime info_center.ui_v2_n{tier}_completed int 1 run scoreboard players get {score} race_state")
    for challenge in challenges:
        counts.append(f"data modify storage advancement_race:runtime info_center.ui_challenge_{challenge['key']}_status set from storage advancement_race:match cooperative.challenges.{challenge_runtime_path(challenge['key'])}.status")
    outputs[output_dir / "prepare_generated.mcfunction"] = "\n".join(counts) + "\n"

    populate = ["# Generated by tools/generate_cooperative_config.py. Do not edit by hand."]
    for category in CATEGORY_ORDER:
        for part, chunk in enumerate(category_chunks[category]):
            page_number = category_page_numbers[category][part]
            for advancement in chunk:
                populate.append("function advancement_race:cooperative/ui_v2/add_vanilla_entry " + compact({"id": advancement["vanilla_id"], "title_translate": advancement["title_translate"], "team_points": advancement["team_points"], "border_delta": advancement["border_delta"], "page_index": page_number - 1}))
    for tier in (3, 6, 9, 15):
        for part, chunk in enumerate(tier_chunks[tier]):
            page_number = tier_page_numbers[tier][part]
            for challenge in chunk:
                populate.append("function advancement_race:cooperative/ui_v2/add_challenge_entry " + compact({"path": challenge_runtime_path(challenge["key"]), "title": challenge["title"], "page": detail_pages[challenge["key"]], "page_index": page_number - 1, "team_points": challenge["team_points"], "border_delta": challenge["border_delta"]}))
    outputs[output_dir / "populate_generated.mcfunction"] = "\n".join(populate) + "\n"

    history_chunks = split_pages(challenges)
    history_roster_page = 2 + len(history_chunks)
    history_rules_page = history_roster_page + 1
    history_lines = [
        "# Generated by tools/generate_cooperative_config.py. Do not edit by hand.",
        "data modify storage advancement_race:runtime info_center.pages set value []",
    ]
    history_home = {
        "text": "Advancement Race\n",
        "color": "#8A5A00",
        "bold": True,
        "extra": [
            {"text": "Match #$(match_id) · Co-op Final\n", "color": "#006B73", "bold": False},
            {"text": "$(n_label) · $(game_difficulty_label) · CR $(challenge_rating)\n", "color": "#555555", "bold": False},
            {"text": "End: $(end_reason)\n", "color": "#9A5B00", "bold": False},
            {"text": "Points: $(team_points) · Border: $(border_size)\n", "color": "#8A6500", "bold": False},
            {"text": "Duration: $(duration_minutes)m $(duration_seconds)s\n", "color": "#555555", "bold": False},
            {"text": "Vanilla: $(vanilla_completed)/121 · Custom: $(challenge_completed)/$(required_custom)\nEvents: $(event_count)\n\n", "color": "#2E6B35", "bold": False},
            link("[Challenge History]", 2),
            link(" [Roster]", history_roster_page),
            link(" [Rules]", history_rules_page),
            {"text": "\n[Previous Races]", "color": "#006B73", "bold": True, "underlined": True, "click_event": {"action": "run_command", "command": "/trigger race_menu set 9"}},
            {"text": "\n[Current Info]", "color": "#8A6500", "bold": True, "underlined": True, "click_event": {"action": "run_command", "command": "/trigger race_menu"}},
        ],
    }
    history_lines.append(page(history_home))
    for part, chunk in enumerate(history_chunks):
        page_number = 2 + part
        history_extra: list[dict[str, Any]] = [
            {"text": f"Challenge History · {part + 1}/{len(history_chunks)}\n", "color": "#8A5A00", "bold": True}
        ]
        if part:
            history_extra.append(link("[← Previous]", page_number - 1))
        if part + 1 < len(history_chunks):
            history_extra.append(link("  [Next →]", page_number + 1))
        history_extra.append({"text": "\n\n", "color": "#555555", "bold": False})
        for challenge in chunk:
            key = challenge["key"]
            history_extra.append(
                {
                    "text": f"$(history_challenge_{key}_marker) {challenge['title']}\n",
                    "color": f"$(history_challenge_{key}_color)",
                    "bold": False,
                    "hover_event": {
                        "action": "show_text",
                        "value": {
                            "text": f"N{challenge['unlock_level']} · $(history_challenge_{key}_status)\nTeam Points: +{challenge['team_points']}\nBorder: +{challenge['border_delta']}\nN18 Border: -50",
                            "color": "#555555",
                        },
                    },
                }
            )
        history_lines.append(
            page(
                {
                    "text": "[⌂ Result]\n",
                    "color": "#006B73",
                    "bold": True,
                    "underlined": True,
                    "click_event": {"action": "change_page", "page": 1},
                    "extra": history_extra,
                }
            )
        )
    history_lines.append(
        page(
            {
                "text": "[⌂ Result]\n",
                "color": "#006B73",
                "bold": True,
                "underlined": True,
                "click_event": {"action": "change_page", "page": 1},
                "extra": [
                    {"text": "Team Roster ($(participant_count))", "color": "#8A5A00", "bold": True}
                ],
            }
        )
    )
    history_lines.append(
        page(
            {
                "text": "[⌂ Result]\n",
                "color": "#006B73",
                "bold": True,
                "underlined": True,
                "click_event": {"action": "change_page", "page": 1},
                "extra": [
                    {"text": "Archived Rules\n", "color": "#8A5A00", "bold": True},
                    {"text": "$(n_label) · $(game_difficulty_label) · CR $(challenge_rating)\nRisk: $(risk_label)\nGoals: $(goal_count)\n", "color": "#2B2B2B", "bold": False},
                    {"text": "Survival: $(survival_label)\nBosses: $(boss_label)\nFaster/Tight/Cap: $(faster_label)/$(tight_label)/$(ceiling_label)\nNo Regen: $(regen_label) · Sleep: $(sleep_label)\nDeath Toll: $(death_toll_label)\nFailure Tax: $(failure_tax_label)\nOffline Clock: $(offline_label)", "color": "#555555", "bold": False},
                ],
            }
        )
    )
    outputs[output_dir / "history_build_pages_generated.mcfunction"] = "\n".join(
        "$" + line if "$(" in line else line for line in history_lines
    ) + "\n"
    outputs[output_dir / "history_append_roster_line_generated.mcfunction"] = (
        "# Generated by tools/generate_cooperative_config.py. Do not edit by hand.\n"
        f'$data modify storage advancement_race:runtime info_center.pages[{history_roster_page - 1}].raw.extra append value '
        '{text:"\\n#$(roster_number) $(name)",color:"#2B2B2B",bold:false}\n'
    )

    history_prepare = [
        "# Generated by tools/generate_cooperative_config.py. Do not edit by hand."
    ]
    for challenge in challenges:
        key = challenge["key"]
        runtime_path = challenge_runtime_path(key)
        field = f"history_challenge_{key}"
        source = f"cooperative.challenges.{runtime_path}"
        history_prepare.extend(
            [
                f'data modify storage advancement_race:runtime info_center.{field}_marker set value "—"',
                f'data modify storage advancement_race:runtime info_center.{field}_color set value "#555555"',
                f'data modify storage advancement_race:runtime info_center.{field}_status set value "Unavailable"',
                f'execute if data storage advancement_race:runtime coop_history.{source} run data modify storage advancement_race:runtime info_center.{field}_marker set value "✗"',
                f'execute if data storage advancement_race:runtime coop_history.{source} run data modify storage advancement_race:runtime info_center.{field}_color set value "#9B2226"',
                f'execute if data storage advancement_race:runtime coop_history.{source}.status run data modify storage advancement_race:runtime info_center.{field}_status set from storage advancement_race:runtime coop_history.{source}.status',
                f'execute if data storage advancement_race:runtime coop_history.{source}{{status:"completed"}} run data modify storage advancement_race:runtime info_center.{field}_marker set value "✓"',
                f'execute if data storage advancement_race:runtime coop_history.{source}{{status:"completed"}} run data modify storage advancement_race:runtime info_center.{field}_color set value "#2E6B35"',
            ]
        )
    outputs[output_dir / "history_prepare_generated.mcfunction"] = "\n".join(history_prepare) + "\n"
    return outputs
