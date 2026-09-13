$execute store result score #result_current_points race_state run data get storage advancement_race:runtime result.participants[$(participant_index)].points
scoreboard players set #result_rank race_state 1
scoreboard players set #result_compare_index race_state 0
data modify storage advancement_race:runtime result_work.compare_index set value 0
function advancement_race:result/compare_rank with storage advancement_race:runtime result_work
$execute store result storage advancement_race:runtime result.participants[$(participant_index)].rank int 1 run scoreboard players get #result_rank race_state
