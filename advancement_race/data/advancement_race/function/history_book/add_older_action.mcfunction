scoreboard players operation #history_target_page race_state = #history_page race_state
scoreboard players add #history_target_page race_state 1
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"history_page",page:0}
execute store result storage advancement_race:runtime browser_work.pending_action.page int 1 run scoreboard players get #history_target_page race_state
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime browser_work.navigation set value {}
data modify storage advancement_race:runtime browser_work.navigation.action_code set from storage advancement_race:runtime browser_work.action_code
execute if score #history_nav_count race_state matches 0 run function advancement_race:history_book/append_older_first with storage advancement_race:runtime browser_work.navigation
execute if score #history_nav_count race_state matches 1.. run function advancement_race:history_book/append_older_after with storage advancement_race:runtime browser_work.navigation
scoreboard players add #history_nav_count race_state 1
