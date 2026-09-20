execute store result score #relay_remaining race_state run data get storage advancement_race:match cooperative.challenges.relay.remaining_seconds
scoreboard players remove #relay_remaining race_state 1
execute if score #relay_remaining race_state matches ..0 run scoreboard players set #relay_remaining race_state 0
execute store result storage advancement_race:match cooperative.challenges.relay.remaining_seconds int 1 run scoreboard players get #relay_remaining race_state
execute if score #relay_remaining race_state matches 0 run function advancement_race:cooperative/challenges/relay/timeout
