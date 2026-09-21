execute store result score #crusade_remaining race_state run data get storage advancement_race:match cooperative.challenges.foreign_crusade.remaining_seconds
scoreboard players remove #crusade_remaining race_state 1
execute if score #crusade_remaining race_state matches ..0 run scoreboard players set #crusade_remaining race_state 0
execute store result storage advancement_race:match cooperative.challenges.foreign_crusade.remaining_seconds int 1 run scoreboard players get #crusade_remaining race_state
execute if score #crusade_remaining race_state matches 0 run function advancement_race:cooperative/challenges/foreign_crusade/timeout
