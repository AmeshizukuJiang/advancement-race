data modify storage advancement_race:runtime browser_request set value {view:"advancement_results",source:{kind:"live"}}
execute if data storage advancement_race:runtime advancement_results.source{kind:"history"} run data modify storage advancement_race:runtime browser_request set value {view:"advancement_results",source:{kind:"history"}}
data modify storage advancement_race:runtime browser_request.source.match_id set from storage advancement_race:runtime advancement_results.match_id
data modify storage advancement_race:runtime browser_request.advancement set from storage advancement_race:runtime advancement_results.advancement
function advancement_race:browser/session/begin
function advancement_race:advancement_results/copy_events
execute store result score #advancement_results_participant_count race_state run data get storage advancement_race:runtime advancement_results_source.participants
execute store result score #advancement_results_completed_count race_state run data get storage advancement_race:runtime advancement_results.events
scoreboard players operation #advancement_results_not_completed race_state = #advancement_results_participant_count race_state
scoreboard players operation #advancement_results_not_completed race_state -= #advancement_results_completed_count race_state
execute if score #advancement_results_not_completed race_state matches ..-1 run scoreboard players set #advancement_results_not_completed race_state 0
execute store result storage advancement_race:runtime advancement_results.participant_count int 1 run scoreboard players get #advancement_results_participant_count race_state
execute store result storage advancement_race:runtime advancement_results.completed_count int 1 run scoreboard players get #advancement_results_completed_count race_state
execute store result storage advancement_race:runtime advancement_results.not_completed_count int 1 run scoreboard players get #advancement_results_not_completed race_state
function advancement_race:advancement_results/build_pages
data modify storage advancement_race:runtime advancement_results.status set value "ready"
function advancement_race:browser/session/finalize
function advancement_race:advancement_results/give_item with storage advancement_race:runtime advancement_results
