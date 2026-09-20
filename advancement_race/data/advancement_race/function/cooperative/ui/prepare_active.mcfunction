data modify storage advancement_race:runtime info_center.team_points set from storage advancement_race:match cooperative.team_points
data modify storage advancement_race:runtime info_center.border_size set from storage advancement_race:match cooperative.border.size
data modify storage advancement_race:runtime info_center.shrink_milli set from storage advancement_race:match cooperative.border.shrink_milli_per_second
data modify storage advancement_race:runtime info_center.duration_ticks set from storage advancement_race:match cooperative.duration_ticks
data modify storage advancement_race:runtime info_center.vanilla_completed set from storage advancement_race:match cooperative.vanilla_completed
data modify storage advancement_race:runtime info_center.challenge_completed set from storage advancement_race:match cooperative.challenge_completed
data modify storage advancement_race:runtime info_center.supply set from storage advancement_race:match cooperative.challenges.supply
data modify storage advancement_race:runtime info_center.relay set from storage advancement_race:match cooperative.challenges.relay
data modify storage advancement_race:runtime info_center.supply_iron set from storage advancement_race:match cooperative.challenges.supply.iron
data modify storage advancement_race:runtime info_center.supply_iron_target set from storage advancement_race:match cooperative.challenges.supply.iron_target
data modify storage advancement_race:runtime info_center.supply_gold set from storage advancement_race:match cooperative.challenges.supply.gold
data modify storage advancement_race:runtime info_center.supply_gold_target set from storage advancement_race:match cooperative.challenges.supply.gold_target
data modify storage advancement_race:runtime info_center.supply_diamond set from storage advancement_race:match cooperative.challenges.supply.diamond
data modify storage advancement_race:runtime info_center.supply_diamond_target set from storage advancement_race:match cooperative.challenges.supply.diamond_target
data modify storage advancement_race:runtime info_center.supply_obsidian set from storage advancement_race:match cooperative.challenges.supply.obsidian
data modify storage advancement_race:runtime info_center.supply_obsidian_target set from storage advancement_race:match cooperative.challenges.supply.obsidian_target
data modify storage advancement_race:runtime info_center.relay_status set from storage advancement_race:match cooperative.challenges.relay.status
data modify storage advancement_race:runtime info_center.relay_remaining_seconds set from storage advancement_race:match cooperative.challenges.relay.remaining_seconds
function advancement_race:cooperative/ui/prepare_rate
execute store result score #coop_ui_duration race_state run data get storage advancement_race:match cooperative.duration_ticks
scoreboard players set #coop_ui_twenty race_state 20
scoreboard players operation #coop_ui_duration race_state /= #coop_ui_twenty race_state
scoreboard players set #coop_ui_sixty race_state 60
scoreboard players operation #coop_ui_minutes race_state = #coop_ui_duration race_state
scoreboard players operation #coop_ui_minutes race_state /= #coop_ui_sixty race_state
scoreboard players operation #coop_ui_seconds race_state = #coop_ui_duration race_state
scoreboard players operation #coop_ui_seconds race_state %= #coop_ui_sixty race_state
execute store result storage advancement_race:runtime info_center.duration_minutes int 1 run scoreboard players get #coop_ui_minutes race_state
execute store result storage advancement_race:runtime info_center.duration_seconds int 1 run scoreboard players get #coop_ui_seconds race_state
data modify storage advancement_race:runtime info_center.relay_zombie_label set value "Pending"
data modify storage advancement_race:runtime info_center.relay_skeleton_label set value "Pending"
data modify storage advancement_race:runtime info_center.relay_creeper_label set value "Pending"
execute if data storage advancement_race:match cooperative.challenges.relay{zombie:1b} run data modify storage advancement_race:runtime info_center.relay_zombie_label set value "Done"
execute if data storage advancement_race:match cooperative.challenges.relay{skeleton:1b} run data modify storage advancement_race:runtime info_center.relay_skeleton_label set value "Done"
execute if data storage advancement_race:match cooperative.challenges.relay{creeper:1b} run data modify storage advancement_race:runtime info_center.relay_creeper_label set value "Done"
