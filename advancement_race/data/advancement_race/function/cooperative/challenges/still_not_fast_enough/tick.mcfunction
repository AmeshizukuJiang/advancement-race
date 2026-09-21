execute store result score #still_remaining race_state run data get storage advancement_race:match cooperative.challenges.still_not_fast_enough.remaining_seconds
scoreboard players remove #still_remaining race_state 1
execute if score #still_remaining race_state matches ..0 run scoreboard players set #still_remaining race_state 0
execute store result storage advancement_race:match cooperative.challenges.still_not_fast_enough.remaining_seconds int 1 run scoreboard players get #still_remaining race_state
execute if score #still_remaining race_state matches 0 run function advancement_race:cooperative/challenges/still_not_fast_enough/timeout
