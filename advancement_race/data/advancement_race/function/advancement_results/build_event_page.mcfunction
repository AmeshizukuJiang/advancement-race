$data modify storage advancement_race:runtime advancement_results_work.player_name set from storage advancement_race:runtime advancement_results.events[$(page_index)].player_name
$data modify storage advancement_race:runtime advancement_results_work.place set from storage advancement_race:runtime advancement_results.events[$(page_index)].place
$data modify storage advancement_race:runtime advancement_results_work.points set from storage advancement_race:runtime advancement_results.events[$(page_index)].points
data modify storage advancement_race:runtime advancement_results_work.title_translate set from storage advancement_race:runtime advancement_results.title_translate
execute if score #advancement_results_page_slot race_state matches 0 run function advancement_race:advancement_results/append_event_page with storage advancement_race:runtime advancement_results_work
execute if score #advancement_results_page_slot race_state matches 1 run function advancement_race:advancement_results/append_event_to_page with storage advancement_race:runtime advancement_results_work
scoreboard players add #advancement_results_page_slot race_state 1
execute if score #advancement_results_page_slot race_state matches 2 run scoreboard players set #advancement_results_page_slot race_state 0
