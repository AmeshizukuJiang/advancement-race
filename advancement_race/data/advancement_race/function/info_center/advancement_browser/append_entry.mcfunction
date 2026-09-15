execute if score #info_center_category_entries race_state matches 5.. run function advancement_race:info_center/advancement_browser/next_page
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"advancement_detail"}
data modify storage advancement_race:runtime browser_work.pending_action.advancement set from storage advancement_race:runtime info_center_work.entry.advancement
data modify storage advancement_race:runtime browser_work.pending_action.title_translate set from storage advancement_race:runtime info_center_work.entry.title_translate
data modify storage advancement_race:runtime browser_work.pending_action.base_score set from storage advancement_race:runtime info_center_work.entry.base_score
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center_work.entry.action_code set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime info_center_work.entry.player_count set from storage advancement_race:runtime info_center.player_count
execute if score #info_center_participating race_state matches 0 run function advancement_race:info_center/advancement_browser/append_entry_observer with storage advancement_race:runtime info_center_work.entry
execute if score #info_center_participating race_state matches 1 if data storage advancement_race:runtime info_center_work.entry{completed:1b} run function advancement_race:info_center/advancement_browser/append_entry_completed with storage advancement_race:runtime info_center_work.entry
execute if score #info_center_participating race_state matches 1 unless data storage advancement_race:runtime info_center_work.entry{completed:1b} run function advancement_race:info_center/advancement_browser/append_entry_incomplete with storage advancement_race:runtime info_center_work.entry
scoreboard players add #info_center_category_entries race_state 1
