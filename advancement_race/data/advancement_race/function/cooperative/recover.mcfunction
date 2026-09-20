execute store result score #coop_team_points race_state run data get storage advancement_race:match cooperative.team_points
execute store result score #coop_duration_ticks race_state run data get storage advancement_race:match cooperative.duration_ticks
execute store result score #coop_vanilla_completed race_state run data get storage advancement_race:match cooperative.vanilla_completed
execute store result score #coop_challenge_completed race_state run data get storage advancement_race:match cooperative.challenge_completed
execute store result score #coop_border_milli race_state run data get storage advancement_race:match cooperative.border.size_milli
scoreboard players set #coop_tick race_state 0
function advancement_race:cooperative/border/sync
