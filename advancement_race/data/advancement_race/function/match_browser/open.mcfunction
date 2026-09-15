$data modify storage advancement_race:runtime browser_request set value {view:"match_actions",source:{kind:"history",match_id:$(match_id)}}
function advancement_race:browser/session/begin
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"my_result"}
data modify storage advancement_race:runtime browser_work.pending_action.match_id set from storage advancement_race:runtime browser_work.session.source.match_id
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime browser_work.my_result_action_code set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"final_standings"}
data modify storage advancement_race:runtime browser_work.pending_action.match_id set from storage advancement_race:runtime browser_work.session.source.match_id
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime browser_work.final_standings_action_code set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"advancement_index"}
data modify storage advancement_race:runtime browser_work.pending_action.match_id set from storage advancement_race:runtime browser_work.session.source.match_id
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime browser_work.advancement_index_action_code set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.match_id set from storage advancement_race:runtime browser_work.session.source.match_id
function advancement_race:browser/session/finalize
function advancement_race:match_browser/show_actions with storage advancement_race:runtime browser_work
