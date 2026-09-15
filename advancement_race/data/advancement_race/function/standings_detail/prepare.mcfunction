data modify storage advancement_race:runtime standings_detail.mode set from storage advancement_race:runtime standings.mode
data modify storage advancement_race:runtime standings_detail.match_id set from storage advancement_race:runtime standings.match_id
data modify storage advancement_race:runtime standings_detail.player_name set from storage advancement_race:runtime standings_detail.participant.name
data modify storage advancement_race:runtime standings_detail.player_uuid set from storage advancement_race:runtime standings_detail.participant.uuid
data modify storage advancement_race:runtime standings_detail.points set from storage advancement_race:runtime standings_detail.participant.points
data modify storage advancement_race:runtime standings_detail.rank set from storage advancement_race:runtime standings_detail.participant.rank
data modify storage advancement_race:runtime standings_detail.completed set from storage advancement_race:runtime standings_detail.participant.completed
data modify storage advancement_race:runtime browser_request set value {view:"participant_detail",source:{kind:"live"}}
execute if data storage advancement_race:runtime standings_detail.source{kind:"history"} run data modify storage advancement_race:runtime browser_request set value {view:"participant_detail",source:{kind:"history"}}
data modify storage advancement_race:runtime browser_request.source.match_id set from storage advancement_race:runtime standings_detail.match_id
function advancement_race:browser/session/begin
function advancement_race:standings_detail/copy_events
function advancement_race:standings_detail/build_pages
function advancement_race:browser/session/finalize
function advancement_race:standings_detail/give_item with storage advancement_race:runtime standings_detail
