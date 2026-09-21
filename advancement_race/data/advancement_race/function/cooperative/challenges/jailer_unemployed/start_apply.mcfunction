function advancement_race:cooperative/challenges/jailer_unemployed/cleanup_targets
execute at @s run tag @e[type=minecraft:warden,distance=..32,limit=1,sort=nearest] add advancement_race_n15_jailer_warden
execute at @s run tag @e[type=minecraft:wither,distance=..32,limit=1,sort=nearest] add advancement_race_n15_jailer_wither
data modify storage advancement_race:match cooperative.challenges.jailer_unemployed.status set value "active"
data modify storage advancement_race:match cooperative.challenges.jailer_unemployed.last_attacker_warden set value 0b
execute store result score #jailer_attempts race_state run data get storage advancement_race:match cooperative.challenges.jailer_unemployed.attempts
scoreboard players add #jailer_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.jailer_unemployed.attempts int 1 run scoreboard players get #jailer_attempts race_state
tellraw @a [{"text":"Jailer Unemployed targets bound! ","color":"aqua","bold":true},{"text":"The bound Warden must land the killing blow on the bound Wither.","color":"gray","bold":false}]
