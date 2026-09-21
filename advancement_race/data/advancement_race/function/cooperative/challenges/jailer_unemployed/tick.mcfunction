scoreboard players set #jailer_wither_present race_state 0
scoreboard players set #jailer_warden_present race_state 0
scoreboard players set #jailer_attacker_match race_state 0
execute in minecraft:overworld if entity @e[type=minecraft:wither,tag=advancement_race_n15_jailer_wither,limit=1] run scoreboard players set #jailer_wither_present race_state 1
execute in minecraft:the_nether if entity @e[type=minecraft:wither,tag=advancement_race_n15_jailer_wither,limit=1] run scoreboard players set #jailer_wither_present race_state 1
execute in minecraft:the_end if entity @e[type=minecraft:wither,tag=advancement_race_n15_jailer_wither,limit=1] run scoreboard players set #jailer_wither_present race_state 1
execute in minecraft:overworld if entity @e[type=minecraft:warden,tag=advancement_race_n15_jailer_warden,limit=1] run scoreboard players set #jailer_warden_present race_state 1
execute in minecraft:the_nether if entity @e[type=minecraft:warden,tag=advancement_race_n15_jailer_warden,limit=1] run scoreboard players set #jailer_warden_present race_state 1
execute in minecraft:the_end if entity @e[type=minecraft:warden,tag=advancement_race_n15_jailer_warden,limit=1] run scoreboard players set #jailer_warden_present race_state 1
execute in minecraft:overworld as @e[type=minecraft:wither,tag=advancement_race_n15_jailer_wither,limit=1] on attacker if entity @s[type=minecraft:warden,tag=advancement_race_n15_jailer_warden] run scoreboard players set #jailer_attacker_match race_state 1
execute in minecraft:the_nether as @e[type=minecraft:wither,tag=advancement_race_n15_jailer_wither,limit=1] on attacker if entity @s[type=minecraft:warden,tag=advancement_race_n15_jailer_warden] run scoreboard players set #jailer_attacker_match race_state 1
execute in minecraft:the_end as @e[type=minecraft:wither,tag=advancement_race_n15_jailer_wither,limit=1] on attacker if entity @s[type=minecraft:warden,tag=advancement_race_n15_jailer_warden] run scoreboard players set #jailer_attacker_match race_state 1
execute if score #jailer_wither_present race_state matches 1 if score #jailer_attacker_match race_state matches 1 run data modify storage advancement_race:match cooperative.challenges.jailer_unemployed.last_attacker_warden set value 1b
execute if score #jailer_wither_present race_state matches 1 unless score #jailer_attacker_match race_state matches 1 run data modify storage advancement_race:match cooperative.challenges.jailer_unemployed.last_attacker_warden set value 0b
execute if score #jailer_wither_present race_state matches 0 if score #jailer_warden_present race_state matches 1 if data storage advancement_race:match cooperative.challenges.jailer_unemployed{last_attacker_warden:1b} run function advancement_race:cooperative/challenges/jailer_unemployed/found
