execute store result score #relay_ii_remaining race_state run data get storage advancement_race:match cooperative.challenges.relay_ii.remaining_seconds
scoreboard players remove #relay_ii_remaining race_state 1
execute if score #relay_ii_remaining race_state matches ..0 run scoreboard players set #relay_ii_remaining race_state 0
execute store result storage advancement_race:match cooperative.challenges.relay_ii.remaining_seconds int 1 run scoreboard players get #relay_ii_remaining race_state
execute if score #relay_ii_remaining race_state matches 0 run function advancement_race:cooperative/challenges/relay_ii/timeout
