data modify storage advancement_race:runtime standings_request set value {}
data modify storage advancement_race:runtime standings_request.participant_index set from storage advancement_race:runtime browser_work.action.participant_index
data modify storage advancement_race:runtime standings_request.source set from storage advancement_race:runtime browser_work.session.source
data modify storage advancement_race:runtime standings_request.match_id set from storage advancement_race:runtime browser_work.session.source.match_id
function advancement_race:browser/action/participant_detail_validate with storage advancement_race:runtime standings_request
