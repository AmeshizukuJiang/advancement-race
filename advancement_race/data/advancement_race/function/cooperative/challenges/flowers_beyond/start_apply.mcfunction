data modify storage advancement_race:match cooperative.challenges.flowers_beyond.status set value "active"
data modify storage advancement_race:match cooperative.challenges.flowers_beyond.remaining_seconds set value 180
data modify storage advancement_race:match cooperative.challenges.flowers_beyond.completed_count set value 0
data modify storage advancement_race:match cooperative.challenges.flowers_beyond.crops_count set value 0
data modify storage advancement_race:match cooperative.challenges.flowers_beyond.saplings_fungi_count set value 0
data modify storage advancement_race:match cooperative.challenges.flowers_beyond.flowers_count set value 0
data modify storage advancement_race:match cooperative.challenges.flowers_beyond.wild_count set value 0
data modify storage advancement_race:match cooperative.challenges.flowers_beyond.placed set value {}
execute store result score #flowers_attempts race_state run data get storage advancement_race:match cooperative.challenges.flowers_beyond.attempts
scoreboard players add #flowers_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.flowers_beyond.attempts int 1 run scoreboard players get #flowers_attempts race_state
execute as @a[scores={race_participant=0..}] run function advancement_race:cooperative/challenges/flowers_beyond/revoke_generated
tellraw @a [{"text":"Flowers Beyond started! ","color":"aqua","bold":true},{"text":"Place all 86 required plants within 3 minutes. Team placements are shared; the plants need not remain placed.","color":"gray","bold":false}]
