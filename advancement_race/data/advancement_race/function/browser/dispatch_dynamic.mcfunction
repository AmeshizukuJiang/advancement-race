scoreboard players set #browser_valid race_state 1
scoreboard players set #browser_dispatched race_state 0
scoreboard players set #browser_dispatch_stride race_state 256
scoreboard players operation #browser_raw_action race_state = @s race_menu
scoreboard players remove #browser_raw_action race_state 1000
scoreboard players operation #browser_clicked_token race_state = #browser_raw_action race_state
scoreboard players operation #browser_clicked_token race_state /= #browser_dispatch_stride race_state
scoreboard players operation #browser_clicked_index race_state = #browser_raw_action race_state
scoreboard players operation #browser_clicked_index race_state %= #browser_dispatch_stride race_state
execute unless score @s race_browser matches -2147483648..2147483647 run scoreboard players set #browser_valid race_state 0
execute if score @s race_browser matches -2147483648..2147483647 unless score #browser_clicked_token race_state = @s race_browser run scoreboard players set #browser_valid race_state 0
data modify storage advancement_race:runtime browser_work set value {session_found:0b,session_index:0}
scoreboard players set #browser_session_index race_state 0
execute store result storage advancement_race:runtime browser_work.clicked_token int 1 run scoreboard players get #browser_clicked_token race_state
execute store result storage advancement_race:runtime browser_work.action_index int 1 run scoreboard players get #browser_clicked_index race_state
data modify storage advancement_race:runtime browser_work.clicker_uuid set from entity @s UUID
execute if score #browser_valid race_state matches 1 run function advancement_race:browser/find_session with storage advancement_race:runtime browser_work
execute if score #browser_valid race_state matches 1 unless data storage advancement_race:runtime browser_work{session_found:1b} run scoreboard players set #browser_valid race_state 0
execute if score #browser_valid race_state matches 1 run function advancement_race:browser/validate_owner
execute if score #browser_valid race_state matches 1 run function advancement_race:browser/validate_context
execute if score #browser_valid race_state matches 1 run function advancement_race:browser/select_action with storage advancement_race:runtime browser_work
execute if score #browser_valid race_state matches 1 unless data storage advancement_race:runtime browser_work.action run scoreboard players set #browser_valid race_state 0
execute if score #browser_valid race_state matches 1 run function advancement_race:browser/dispatch_action
execute unless score #browser_valid race_state matches 1 run function advancement_race:browser/stale
