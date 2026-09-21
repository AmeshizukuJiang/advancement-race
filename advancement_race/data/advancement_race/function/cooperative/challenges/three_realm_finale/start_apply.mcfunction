function advancement_race:cooperative/challenges/three_realm_finale/cleanup_targets
execute in minecraft:overworld run tag @e[type=minecraft:warden,limit=1,sort=arbitrary] add advancement_race_n9_finale_warden
execute in minecraft:the_nether run tag @e[type=minecraft:wither,limit=1,sort=arbitrary] add advancement_race_n9_finale_wither
execute in minecraft:the_end run tag @e[type=minecraft:ender_dragon,limit=1,sort=arbitrary] add advancement_race_n9_finale_dragon
data modify storage advancement_race:match cooperative.challenges.three_realm_finale.status set value "active"
data modify storage advancement_race:match cooperative.challenges.three_realm_finale.remaining_seconds set value 300
data modify storage advancement_race:match cooperative.challenges.three_realm_finale.warden set value 0b
data modify storage advancement_race:match cooperative.challenges.three_realm_finale.wither set value 0b
data modify storage advancement_race:match cooperative.challenges.three_realm_finale.dragon set value 0b
execute store result score #finale_attempts race_state run data get storage advancement_race:match cooperative.challenges.three_realm_finale.attempts
scoreboard players add #finale_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.three_realm_finale.attempts int 1 run scoreboard players get #finale_attempts race_state
execute as @a[scores={race_participant=0..}] run function advancement_race:cooperative/challenges/three_realm_finale/revoke_helpers
tellraw @a [{"text":"Three-Realm Finale started! ","color":"aqua","bold":true},{"text":"Kill the bound Overworld Warden, Nether Wither, and Ender Dragon within 5 minutes.","color":"gray","bold":false}]
