execute store result score #coop_team_points race_state run data get storage advancement_race:match cooperative.team_points
execute store result score #coop_duration_ticks race_state run data get storage advancement_race:match cooperative.duration_ticks
execute store result score #coop_vanilla_completed race_state run data get storage advancement_race:match cooperative.vanilla_completed
execute store result score #coop_challenge_completed race_state run data get storage advancement_race:match cooperative.challenge_completed
execute store result score #coop_border_milli race_state run data get storage advancement_race:match cooperative.border.size_milli
function advancement_race:cooperative/challenges/initialize_prototype
scoreboard players set #coop_tick race_state 0
function advancement_race:cooperative/rules/apply_difficulty
function advancement_race:cooperative/rules/apply_survival_world
function advancement_race:cooperative/rules/apply_independent_world
execute as @a[scores={race_participant=0..}] run function advancement_race:cooperative/rules/apply_survival_player
function advancement_race:cooperative/challenges/death/check
scoreboard players set @a[scores={race_participant=0..}] race_cold_strider 0
execute as @a[scores={race_participant=0..}] run scoreboard players operation @s race_challenge_death_seen = @s race_deaths
function advancement_race:cooperative/border/sync
