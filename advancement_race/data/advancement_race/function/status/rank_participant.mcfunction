$execute store result score #status_current_points race_state run data get storage advancement_race:runtime status.participants[$(participant_index)].points
scoreboard players set #status_rank race_state 1
scoreboard players set #status_compare_index race_state 0
data modify storage advancement_race:runtime status_work.compare_index set value 0
function advancement_race:status/compare_rank with storage advancement_race:runtime status_work
$execute store result storage advancement_race:runtime status.participants[$(participant_index)].rank int 1 run scoreboard players get #status_rank race_state
