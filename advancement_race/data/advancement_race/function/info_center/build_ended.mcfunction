data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"info_center_select_match"}
data modify storage advancement_race:runtime browser_work.pending_action.match_id set from storage advancement_race:runtime info_center.match_id
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.history_action_code set from storage advancement_race:runtime browser_work.action_code
function advancement_race:info_center/build_ended_page with storage advancement_race:runtime info_center
data modify storage advancement_race:runtime info_center.status set value "ready"
