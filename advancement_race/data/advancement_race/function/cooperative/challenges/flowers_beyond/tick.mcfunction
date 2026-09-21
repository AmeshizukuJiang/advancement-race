execute store result score #flowers_remaining race_state run data get storage advancement_race:match cooperative.challenges.flowers_beyond.remaining_seconds
scoreboard players remove #flowers_remaining race_state 1
execute if score #flowers_remaining race_state matches ..0 run scoreboard players set #flowers_remaining race_state 0
execute store result storage advancement_race:match cooperative.challenges.flowers_beyond.remaining_seconds int 1 run scoreboard players get #flowers_remaining race_state
execute if score #flowers_remaining race_state matches 0 run function advancement_race:cooperative/challenges/flowers_beyond/timeout
