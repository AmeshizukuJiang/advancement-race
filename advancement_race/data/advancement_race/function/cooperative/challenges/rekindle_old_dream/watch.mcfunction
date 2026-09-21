tag @a remove advancement_race_n15_old_dream_player
tag @s add advancement_race_n15_old_dream_player
data modify storage advancement_race:match cooperative.challenges.rekindle_old_dream.status set value "watching"
data modify storage advancement_race:match cooperative.challenges.rekindle_old_dream.window_ticks set value 40
tellraw @a [{"text":"Bed explosion detected. ","color":"aqua","bold":true},{"text":"Watching the bound Ender Dragon for two seconds.","color":"gray","bold":false}]
