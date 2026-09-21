execute store result score #wrong_remaining race_state run data get storage advancement_race:match cooperative.challenges.something_is_wrong.remaining_seconds
scoreboard players remove #wrong_remaining race_state 1
execute if score #wrong_remaining race_state matches ..0 run scoreboard players set #wrong_remaining race_state 0
execute store result storage advancement_race:match cooperative.challenges.something_is_wrong.remaining_seconds int 1 run scoreboard players get #wrong_remaining race_state
execute if score #wrong_remaining race_state matches 0 run function advancement_race:cooperative/challenges/something_is_wrong/timeout
