$data modify storage advancement_race:runtime browser_request set value {view:"match_actions",source:{kind:"history",match_id:$(match_id)}}
function advancement_race:browser/session/begin
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"my_result"}
data modify storage advancement_race:runtime browser_work.pending_action.match_id set from storage advancement_race:runtime browser_work.session.source.match_id
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime browser_work.match_id set from storage advancement_race:runtime browser_work.session.source.match_id
function advancement_race:browser/session/finalize
function advancement_race:match_browser/show_actions with storage advancement_race:runtime browser_work
