$execute if data storage advancement_race:runtime status.participants[$(compare_index)] run function advancement_race:status/compare_rank_step with storage advancement_race:runtime status_work
$execute if data storage advancement_race:runtime status.participants[$(compare_index)] run scoreboard players add #status_compare_index race_state 1
$execute if data storage advancement_race:runtime status.participants[$(compare_index)] run execute store result storage advancement_race:runtime status_work.compare_index int 1 run scoreboard players get #status_compare_index race_state
$execute if data storage advancement_race:runtime status.participants[$(compare_index)] run function advancement_race:status/compare_rank with storage advancement_race:runtime status_work
