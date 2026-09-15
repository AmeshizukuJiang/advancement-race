data modify storage advancement_race:runtime standings_request set value {}
data modify storage advancement_race:runtime standings_request.match_id set from storage advancement_race:runtime browser_work.action.match_id
function advancement_race:browser/action/final_standings_validate with storage advancement_race:runtime standings_request
