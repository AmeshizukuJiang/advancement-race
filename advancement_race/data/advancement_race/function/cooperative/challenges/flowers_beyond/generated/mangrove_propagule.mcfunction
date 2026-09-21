advancement revoke @s only advancement_race_coop:challenge/flowers_beyond/mangrove_propagule
scoreboard players set #flowers_new race_state 0
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border",cooperative:{challenges:{flowers_beyond:{status:"active"}}}} if score @s race_participant matches 0.. unless data storage advancement_race:match cooperative.challenges.flowers_beyond.placed.mangrove_propagule run scoreboard players set #flowers_new race_state 1
execute if score #flowers_new race_state matches 1 run data modify storage advancement_race:match cooperative.challenges.flowers_beyond.placed.mangrove_propagule set value 1b
execute if score #flowers_new race_state matches 1 store result score #flowers_total race_state run data get storage advancement_race:match cooperative.challenges.flowers_beyond.completed_count
execute if score #flowers_new race_state matches 1 run scoreboard players add #flowers_total race_state 1
execute if score #flowers_new race_state matches 1 store result storage advancement_race:match cooperative.challenges.flowers_beyond.completed_count int 1 run scoreboard players get #flowers_total race_state
execute if score #flowers_new race_state matches 1 store result score #flowers_group race_state run data get storage advancement_race:match cooperative.challenges.flowers_beyond.saplings_fungi_count
execute if score #flowers_new race_state matches 1 run scoreboard players add #flowers_group race_state 1
execute if score #flowers_new race_state matches 1 store result storage advancement_race:match cooperative.challenges.flowers_beyond.saplings_fungi_count int 1 run scoreboard players get #flowers_group race_state
execute if score #flowers_new race_state matches 1 run title @a[scores={race_participant=0..}] actionbar [{"text":"Flowers Beyond · Mangrove Propagule · ","color":"aqua"},{"score":{"name":"#flowers_total","objective":"race_state"},"color":"yellow"},{"text":"/86","color":"gray"}]
execute if score #flowers_new race_state matches 1 if score #flowers_total race_state matches 86 run function advancement_race:cooperative/challenges/flowers_beyond/complete
