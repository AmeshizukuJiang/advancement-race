$execute store result score #result_compare_points race_state run data get storage advancement_race:runtime result.participants[$(compare_index)].points
execute if score #result_compare_points race_state > #result_current_points race_state run scoreboard players add #result_rank race_state 1
