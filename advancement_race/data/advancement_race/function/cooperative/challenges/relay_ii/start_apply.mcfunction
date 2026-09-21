data modify storage advancement_race:match cooperative.challenges.relay_ii.status set value "active"
data modify storage advancement_race:match cooperative.challenges.relay_ii.remaining_seconds set value 480
data modify storage advancement_race:match cooperative.challenges.relay_ii.drowned set value 0b
data modify storage advancement_race:match cooperative.challenges.relay_ii.blaze set value 0b
data modify storage advancement_race:match cooperative.challenges.relay_ii.enderman set value 0b
data modify storage advancement_race:match cooperative.challenges.relay_ii.pillager set value 0b
data modify storage advancement_race:match cooperative.challenges.relay_ii.phantom set value 0b
data modify storage advancement_race:match cooperative.challenges.relay_ii.slime set value 0b
execute store result score #relay_ii_attempts race_state run data get storage advancement_race:match cooperative.challenges.relay_ii.attempts
scoreboard players add #relay_ii_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.relay_ii.attempts int 1 run scoreboard players get #relay_ii_attempts race_state
execute as @a[scores={race_participant=0..}] run function advancement_race:cooperative/challenges/relay_ii/revoke_helpers
tellraw @a [{"text":"Calamity Relay II started! ","color":"aqua","bold":true},{"text":"Kill a Drowned, Blaze, Enderman, Pillager, Phantom, and Slime within 8 minutes.","color":"gray","bold":false}]
