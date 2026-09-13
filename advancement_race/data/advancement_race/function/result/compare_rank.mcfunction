$execute if data storage advancement_race:runtime result.participants[$(compare_index)] run function advancement_race:result/compare_rank_step with storage advancement_race:runtime result_work
$execute if data storage advancement_race:runtime result.participants[$(compare_index)] run scoreboard players add #result_compare_index race_state 1
$execute if data storage advancement_race:runtime result.participants[$(compare_index)] run execute store result storage advancement_race:runtime result_work.compare_index int 1 run scoreboard players get #result_compare_index race_state
$execute if data storage advancement_race:runtime result.participants[$(compare_index)] run function advancement_race:result/compare_rank with storage advancement_race:runtime result_work
