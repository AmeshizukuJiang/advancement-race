function advancement_race:cooperative/challenges/three_realm_merchant/cleanup_target
execute at @s run tag @e[type=minecraft:villager,distance=..8,limit=1,sort=nearest] add advancement_race_n15_merchant
execute at @s as @e[type=minecraft:villager,tag=advancement_race_n15_merchant,distance=..8,limit=1,sort=nearest] run data modify storage advancement_race:match cooperative.challenges.three_realm_merchant.villager_uuid set from entity @s UUID
data modify storage advancement_race:match cooperative.challenges.three_realm_merchant.status set value "active"
data modify storage advancement_race:match cooperative.challenges.three_realm_merchant.overworld set value 0b
data modify storage advancement_race:match cooperative.challenges.three_realm_merchant.nether set value 0b
data modify storage advancement_race:match cooperative.challenges.three_realm_merchant.end set value 0b
execute store result score #n15_merchant_attempts race_state run data get storage advancement_race:match cooperative.challenges.three_realm_merchant.attempts
scoreboard players add #n15_merchant_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.three_realm_merchant.attempts int 1 run scoreboard players get #n15_merchant_attempts race_state
execute as @a[scores={race_participant=0..}] run function advancement_race:cooperative/challenges/three_realm_merchant/revoke_helpers
tellraw @a [{"text":"Three-Realm Merchant bound! ","color":"aqua","bold":true},{"text":"Trade with the tagged Villager once in the Overworld, Nether, and End. Rebinding restarts all progress.","color":"gray","bold":false}]
