data modify storage advancement_race:match rules.cooperative.border.initial_size set from storage advancement_race:match rules.cooperative.v11.profile.initial_border
data modify storage advancement_race:match rules.cooperative.border.maximum_size set from storage advancement_race:match rules.cooperative.v11.profile.maximum_border
data modify storage advancement_race:match rules.cooperative.border.base_shrink_milli_per_second set from storage advancement_race:match rules.cooperative.v11.profile.shrink_milli_per_second
# Modifier order is fixed: N profile -> Tight Start -> Faster Clock -> Low Ceiling.
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{tight_start:1b} store result score #coop_profile_value race_state run data get storage advancement_race:match rules.cooperative.border.initial_size
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{tight_start:1b} run scoreboard players set #coop_modifier_milli race_state 750
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{tight_start:1b} run scoreboard players operation #coop_profile_value race_state *= #coop_modifier_milli race_state
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{tight_start:1b} run scoreboard players operation #coop_profile_value race_state /= #coop_thousand race_state
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{tight_start:1b} store result storage advancement_race:match rules.cooperative.border.initial_size int 1 run scoreboard players get #coop_profile_value race_state
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{faster_clock:1b} store result score #coop_profile_value race_state run data get storage advancement_race:match rules.cooperative.border.base_shrink_milli_per_second
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{faster_clock:1b} run scoreboard players set #coop_modifier_milli race_state 1150
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{faster_clock:1b} run scoreboard players operation #coop_profile_value race_state *= #coop_modifier_milli race_state
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{faster_clock:1b} run scoreboard players operation #coop_profile_value race_state /= #coop_thousand race_state
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{faster_clock:1b} store result storage advancement_race:match rules.cooperative.border.base_shrink_milli_per_second int 1 run scoreboard players get #coop_profile_value race_state
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{low_ceiling:1b} store result score #coop_profile_value race_state run data get storage advancement_race:match rules.cooperative.border.maximum_size
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{low_ceiling:1b} run scoreboard players set #coop_modifier_milli race_state 650
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{low_ceiling:1b} run scoreboard players operation #coop_profile_value race_state *= #coop_modifier_milli race_state
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{low_ceiling:1b} run scoreboard players operation #coop_profile_value race_state /= #coop_thousand race_state
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.border{low_ceiling:1b} store result storage advancement_race:match rules.cooperative.border.maximum_size int 1 run scoreboard players get #coop_profile_value race_state
execute store result score #coop_goal_count race_state run data get storage advancement_race:match rules.cooperative.v11.profile.goal_count
scoreboard players operation #coop_required_custom race_state = #coop_goal_count race_state
scoreboard players remove #coop_required_custom race_state 121
execute store result storage advancement_race:match rules.cooperative.v11.required_custom_challenges int 1 run scoreboard players get #coop_required_custom race_state
