data modify storage advancement_race:runtime cooperative_ui_rules set from storage advancement_race:match setup.cooperative
function advancement_race:cooperative/ui/select_preview_profile with storage advancement_race:runtime cooperative_ui_rules
data modify storage advancement_race:runtime cooperative_ui_rules.n_level set from storage advancement_race:runtime cooperative_ui_rules.difficulty_level
data modify storage advancement_race:runtime cooperative_ui_rules.initial_border set from storage advancement_race:runtime cooperative_ui_rules.profile.initial_border
data modify storage advancement_race:runtime cooperative_ui_rules.maximum_border set from storage advancement_race:runtime cooperative_ui_rules.profile.maximum_border
data modify storage advancement_race:runtime cooperative_ui_rules.shrink_milli set from storage advancement_race:runtime cooperative_ui_rules.profile.shrink_milli_per_second
data modify storage advancement_race:runtime cooperative_ui_rules.goal_count set from storage advancement_race:runtime cooperative_ui_rules.profile.goal_count
execute store result score #coop_ui_preview_value race_state run data get storage advancement_race:runtime cooperative_ui_rules.initial_border
execute if data storage advancement_race:runtime cooperative_ui_rules.modifiers.border{tight_start:1b} run scoreboard players set #coop_ui_preview_multiplier race_state 750
execute if data storage advancement_race:runtime cooperative_ui_rules.modifiers.border{tight_start:1b} run scoreboard players operation #coop_ui_preview_value race_state *= #coop_ui_preview_multiplier race_state
execute if data storage advancement_race:runtime cooperative_ui_rules.modifiers.border{tight_start:1b} run scoreboard players set #coop_ui_preview_divisor race_state 1000
execute if data storage advancement_race:runtime cooperative_ui_rules.modifiers.border{tight_start:1b} run scoreboard players operation #coop_ui_preview_value race_state /= #coop_ui_preview_divisor race_state
execute store result storage advancement_race:runtime cooperative_ui_rules.initial_border int 1 run scoreboard players get #coop_ui_preview_value race_state
execute store result score #coop_ui_preview_value race_state run data get storage advancement_race:runtime cooperative_ui_rules.shrink_milli
execute if data storage advancement_race:runtime cooperative_ui_rules.modifiers.border{faster_clock:1b} run scoreboard players set #coop_ui_preview_multiplier race_state 1150
execute if data storage advancement_race:runtime cooperative_ui_rules.modifiers.border{faster_clock:1b} run scoreboard players operation #coop_ui_preview_value race_state *= #coop_ui_preview_multiplier race_state
execute if data storage advancement_race:runtime cooperative_ui_rules.modifiers.border{faster_clock:1b} run scoreboard players set #coop_ui_preview_divisor race_state 1000
execute if data storage advancement_race:runtime cooperative_ui_rules.modifiers.border{faster_clock:1b} run scoreboard players operation #coop_ui_preview_value race_state /= #coop_ui_preview_divisor race_state
execute store result score #coop_ui_preview_players race_state run data get storage advancement_race:match participants
scoreboard players remove #coop_ui_preview_players race_state 4
execute if score #coop_ui_preview_players race_state matches ..0 run scoreboard players set #coop_ui_preview_players race_state 0
execute store result score #coop_ui_preview_extra race_state run data get storage advancement_race:config cooperative.border.extra_player_shrink_milli
scoreboard players operation #coop_ui_preview_extra race_state *= #coop_ui_preview_players race_state
scoreboard players operation #coop_ui_preview_value race_state += #coop_ui_preview_extra race_state
execute store result score #coop_ui_preview_max race_state run data get storage advancement_race:config cooperative.border.maximum_shrink_milli_per_second
execute if score #coop_ui_preview_value race_state > #coop_ui_preview_max race_state run scoreboard players operation #coop_ui_preview_value race_state = #coop_ui_preview_max race_state
execute store result storage advancement_race:runtime cooperative_ui_rules.shrink_milli int 1 run scoreboard players get #coop_ui_preview_value race_state
execute store result score #coop_ui_preview_value race_state run data get storage advancement_race:runtime cooperative_ui_rules.maximum_border
execute if data storage advancement_race:runtime cooperative_ui_rules.modifiers.border{low_ceiling:1b} run scoreboard players set #coop_ui_preview_multiplier race_state 650
execute if data storage advancement_race:runtime cooperative_ui_rules.modifiers.border{low_ceiling:1b} run scoreboard players operation #coop_ui_preview_value race_state *= #coop_ui_preview_multiplier race_state
execute if data storage advancement_race:runtime cooperative_ui_rules.modifiers.border{low_ceiling:1b} run scoreboard players set #coop_ui_preview_divisor race_state 1000
execute if data storage advancement_race:runtime cooperative_ui_rules.modifiers.border{low_ceiling:1b} run scoreboard players operation #coop_ui_preview_value race_state /= #coop_ui_preview_divisor race_state
execute store result storage advancement_race:runtime cooperative_ui_rules.maximum_border int 1 run scoreboard players get #coop_ui_preview_value race_state
execute store result score #coop_ui_required_custom race_state run data get storage advancement_race:runtime cooperative_ui_rules.goal_count
scoreboard players remove #coop_ui_required_custom race_state 121
execute store result storage advancement_race:runtime cooperative_ui_rules.required_custom int 1 run scoreboard players get #coop_ui_required_custom race_state
execute store result score #coop_ui_shrink_milli race_state run data get storage advancement_race:runtime cooperative_ui_rules.shrink_milli
scoreboard players set #coop_ui_thousand race_state 1000
scoreboard players set #coop_ui_hundred race_state 100
scoreboard players operation #coop_ui_shrink_whole race_state = #coop_ui_shrink_milli race_state
scoreboard players operation #coop_ui_shrink_whole race_state /= #coop_ui_thousand race_state
scoreboard players operation #coop_ui_shrink_tenths race_state = #coop_ui_shrink_milli race_state
scoreboard players operation #coop_ui_shrink_tenths race_state %= #coop_ui_thousand race_state
scoreboard players operation #coop_ui_shrink_tenths race_state /= #coop_ui_hundred race_state
execute store result storage advancement_race:runtime cooperative_ui_rules.shrink_whole int 1 run scoreboard players get #coop_ui_shrink_whole race_state
execute store result storage advancement_race:runtime cooperative_ui_rules.shrink_tenths int 1 run scoreboard players get #coop_ui_shrink_tenths race_state
function advancement_race:cooperative/ui/prepare_rule_labels
