execute store result score #eco_remaining race_state run data get storage advancement_race:match cooperative.challenges.ecological_restoration.remaining_seconds
scoreboard players remove #eco_remaining race_state 1
execute if score #eco_remaining race_state matches ..0 run scoreboard players set #eco_remaining race_state 0
execute store result storage advancement_race:match cooperative.challenges.ecological_restoration.remaining_seconds int 1 run scoreboard players get #eco_remaining race_state
execute if score #eco_remaining race_state matches 0 run function advancement_race:cooperative/challenges/ecological_restoration/timeout
