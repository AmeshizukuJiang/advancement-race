data modify storage advancement_race:match cooperative.challenges.rekindle_old_dream.status set value "armed"
data modify storage advancement_race:match cooperative.challenges.rekindle_old_dream.window_ticks set value 0
tag @a remove advancement_race_n15_old_dream_player
tellraw @a [{"text":"The bed explosion did not damage the bound Ender Dragon. ","color":"yellow"},{"text":"The challenge remains armed; try another bed.","color":"gray"}]
