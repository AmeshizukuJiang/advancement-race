function advancement_race:cooperative/challenges/foreign_crusade/cleanup_targets
execute in minecraft:the_end run tag @e[type=minecraft:wither,limit=1,sort=arbitrary] add advancement_race_n15_crusade_end_wither
execute in minecraft:the_nether run tag @e[type=minecraft:evoker,limit=1,sort=arbitrary] add advancement_race_n15_crusade_nether_evoker
execute in minecraft:overworld run tag @e[type=minecraft:shulker,limit=1,sort=arbitrary] add advancement_race_n15_crusade_overworld_shulker
data modify storage advancement_race:match cooperative.challenges.foreign_crusade.status set value "active"
data modify storage advancement_race:match cooperative.challenges.foreign_crusade.remaining_seconds set value 600
data modify storage advancement_race:match cooperative.challenges.foreign_crusade.end_wither set value 0b
data modify storage advancement_race:match cooperative.challenges.foreign_crusade.nether_evoker set value 0b
data modify storage advancement_race:match cooperative.challenges.foreign_crusade.overworld_shulker set value 0b
execute store result score #crusade_attempts race_state run data get storage advancement_race:match cooperative.challenges.foreign_crusade.attempts
scoreboard players add #crusade_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.foreign_crusade.attempts int 1 run scoreboard players get #crusade_attempts race_state
execute as @a[scores={race_participant=0..}] run function advancement_race:cooperative/challenges/foreign_crusade/revoke_helpers
tellraw @a [{"text":"Foreign Crusade started! ","color":"aqua","bold":true},{"text":"Kill the bound End Wither, Nether Evoker, and Overworld Shulker within 10 minutes.","color":"gray","bold":false}]
