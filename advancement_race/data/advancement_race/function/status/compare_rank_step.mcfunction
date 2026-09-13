$execute store result score #status_compare_points race_state run data get storage advancement_race:runtime status.participants[$(compare_index)].points
execute if score #status_compare_points race_state > #status_current_points race_state run scoreboard players add #status_rank race_state 1
