data modify storage advancement_race:runtime cooperative_ui_rules set from storage advancement_race:match rules.cooperative.v11
data modify storage advancement_race:runtime cooperative_ui_rules.n_level set from storage advancement_race:runtime cooperative_ui_rules.difficulty_level
data modify storage advancement_race:runtime cooperative_ui_rules.goal_count set from storage advancement_race:runtime cooperative_ui_rules.profile.goal_count
data modify storage advancement_race:runtime cooperative_ui_rules.required_custom set from storage advancement_race:runtime cooperative_ui_rules.required_custom_challenges
data modify storage advancement_race:runtime cooperative_ui_rules.initial_border set from storage advancement_race:match rules.cooperative.border.initial_size
data modify storage advancement_race:runtime cooperative_ui_rules.maximum_border set from storage advancement_race:match rules.cooperative.border.maximum_size
data modify storage advancement_race:runtime cooperative_ui_rules.shrink_milli set from storage advancement_race:match cooperative.border.shrink_milli_per_second
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
function advancement_race:cooperative/ui/copy_rules_to_info_center
