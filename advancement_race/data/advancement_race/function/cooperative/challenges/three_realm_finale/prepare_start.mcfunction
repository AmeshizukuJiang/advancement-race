scoreboard players set #finale_ready race_state 0
execute in minecraft:overworld if entity @e[type=minecraft:warden,limit=1] run scoreboard players add #finale_ready race_state 1
execute in minecraft:the_nether if entity @e[type=minecraft:wither,limit=1] run scoreboard players add #finale_ready race_state 1
execute in minecraft:the_end if entity @e[type=minecraft:ender_dragon,limit=1] run scoreboard players add #finale_ready race_state 1
execute if score #finale_ready race_state matches 3 run function advancement_race:cooperative/challenges/three_realm_finale/start_apply
execute unless score #finale_ready race_state matches 3 run tellraw @s [{"text":"Three-Realm Finale cannot start. ","color":"red","bold":true},{"text":"Load one Warden in the Overworld, one Wither in the Nether, and one Ender Dragon in the End first.","color":"gray","bold":false}]
