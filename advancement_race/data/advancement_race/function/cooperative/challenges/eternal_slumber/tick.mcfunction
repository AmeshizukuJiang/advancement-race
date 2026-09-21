execute store result score #eternal_remaining race_state run data get storage advancement_race:match cooperative.challenges.eternal_slumber.remaining_seconds
scoreboard players remove #eternal_remaining race_state 1
execute if score #eternal_remaining race_state matches ..0 run scoreboard players set #eternal_remaining race_state 0
execute store result storage advancement_race:match cooperative.challenges.eternal_slumber.remaining_seconds int 1 run scoreboard players get #eternal_remaining race_state
execute if score #eternal_remaining race_state matches 0 run function advancement_race:cooperative/challenges/eternal_slumber/timeout
