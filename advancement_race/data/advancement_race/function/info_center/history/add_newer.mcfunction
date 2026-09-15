scoreboard players operation #info_history_target_page race_state = #info_history_page race_state
scoreboard players remove #info_history_target_page race_state 1
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"info_center_history_page",page:0}
execute store result storage advancement_race:runtime browser_work.pending_action.page int 1 run scoreboard players get #info_history_target_page race_state
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center_history_work.navigation_action set from storage advancement_race:runtime browser_work.action_code
function advancement_race:info_center/history/append_newer with storage advancement_race:runtime info_center_history_work
scoreboard players add #info_history_nav_count race_state 1
