$data modify storage advancement_race:runtime result_work.event set from storage advancement_race:runtime result.events[$(event_index)]
data modify storage advancement_race:runtime result_work.event_player_name set from storage advancement_race:runtime result_work.event.player_name
execute store result score #result_event_points race_state run data get storage advancement_race:runtime result_work.event.points
execute store result score #result_event_sequence race_state run data get storage advancement_race:runtime result_work.event.sequence
scoreboard players set #result_participant_index race_state 0
data modify storage advancement_race:runtime result_work.participant_index set value 0
function advancement_race:result/find_event_participant with storage advancement_race:runtime result_work
