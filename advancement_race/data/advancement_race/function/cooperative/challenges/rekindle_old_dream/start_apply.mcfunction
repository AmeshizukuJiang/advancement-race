function advancement_race:cooperative/challenges/rekindle_old_dream/cleanup
execute in minecraft:the_end run tag @e[type=minecraft:ender_dragon,limit=1,sort=arbitrary] add advancement_race_n15_old_dream_dragon
data modify storage advancement_race:match cooperative.challenges.rekindle_old_dream.status set value "armed"
data modify storage advancement_race:match cooperative.challenges.rekindle_old_dream.window_ticks set value 0
execute in minecraft:the_end store result score #old_dream_baseline race_state run data get entity @e[type=minecraft:ender_dragon,tag=advancement_race_n15_old_dream_dragon,limit=1] Health 1000
execute store result storage advancement_race:match cooperative.challenges.rekindle_old_dream.baseline_health_milli int 1 run scoreboard players get #old_dream_baseline race_state
execute store result score #old_dream_attempts race_state run data get storage advancement_race:match cooperative.challenges.rekindle_old_dream.attempts
scoreboard players add #old_dream_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.rekindle_old_dream.attempts int 1 run scoreboard players get #old_dream_attempts race_state
execute as @a[scores={race_participant=0..}] run advancement revoke @s only advancement_race_coop:challenge/rekindle_old_dream_bed
tellraw @a [{"text":"Rekindle an Old Dream armed! ","color":"aqua","bold":true},{"text":"Damage the bound Ender Dragon with a bed explosion in the End.","color":"gray","bold":false}]
