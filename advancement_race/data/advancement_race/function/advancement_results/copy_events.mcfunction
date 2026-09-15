data modify storage advancement_race:runtime advancement_results.events set value []
data modify storage advancement_race:runtime advancement_results_work set value {event_index:0}
data modify storage advancement_race:runtime advancement_results_work.advancement set from storage advancement_race:runtime advancement_results.advancement
scoreboard players set #advancement_results_event_index race_state 0
function advancement_race:advancement_results/copy_events_loop with storage advancement_race:runtime advancement_results_work
