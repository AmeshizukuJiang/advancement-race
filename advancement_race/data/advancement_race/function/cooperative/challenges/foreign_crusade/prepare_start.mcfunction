scoreboard players set #crusade_ready race_state 0
execute in minecraft:the_end if entity @e[type=minecraft:wither,limit=1] run scoreboard players add #crusade_ready race_state 1
execute in minecraft:the_nether if entity @e[type=minecraft:evoker,limit=1] run scoreboard players add #crusade_ready race_state 1
execute in minecraft:overworld if entity @e[type=minecraft:shulker,limit=1] run scoreboard players add #crusade_ready race_state 1
execute if score #crusade_ready race_state matches 3 run function advancement_race:cooperative/challenges/foreign_crusade/start_apply
execute unless score #crusade_ready race_state matches 3 run tellraw @s [{"text":"Foreign Crusade cannot start. ","color":"red","bold":true},{"text":"Load one Wither in the End, one Evoker in the Nether, and one Shulker in the Overworld first.","color":"gray","bold":false}]
