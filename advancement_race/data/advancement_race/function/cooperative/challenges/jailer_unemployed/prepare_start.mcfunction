scoreboard players set #jailer_ready race_state 0
execute at @s if entity @e[type=minecraft:warden,distance=..32,limit=1] run scoreboard players add #jailer_ready race_state 1
execute at @s if entity @e[type=minecraft:wither,distance=..32,limit=1] run scoreboard players add #jailer_ready race_state 1
execute if score #jailer_ready race_state matches 2 run function advancement_race:cooperative/challenges/jailer_unemployed/start_apply
execute unless score #jailer_ready race_state matches 2 run tellraw @s [{"text":"Jailer Unemployed cannot bind targets. ","color":"red","bold":true},{"text":"Bring one Warden and one Wither within 32 blocks in the same dimension, then retry.","color":"gray","bold":false}]
