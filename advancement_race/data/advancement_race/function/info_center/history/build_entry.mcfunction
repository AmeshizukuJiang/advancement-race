$data modify storage advancement_race:runtime info_center_history_work.entry set from storage advancement_race:history matches[$(history_index)]
execute store result score #info_history_entry_participants race_state run data get storage advancement_race:runtime info_center_history_work.entry.participants
execute store result score #info_history_entry_events race_state run data get storage advancement_race:runtime info_center_history_work.entry.events
execute store result storage advancement_race:runtime info_center_history_work.entry.participant_count int 1 run scoreboard players get #info_history_entry_participants race_state
execute store result storage advancement_race:runtime info_center_history_work.entry.event_count int 1 run scoreboard players get #info_history_entry_events race_state
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"info_center_select_match"}
data modify storage advancement_race:runtime browser_work.pending_action.match_id set from storage advancement_race:runtime info_center_history_work.entry.id
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center_history_work.entry.action_code set from storage advancement_race:runtime browser_work.action_code
function advancement_race:info_center/history/append_entry with storage advancement_race:runtime info_center_history_work.entry
