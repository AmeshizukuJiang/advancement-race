tag @s add advancement_race_n15_moon_dragon
data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.dragon_uuid set from entity @s UUID
data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.status set value "active"
data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.remaining_ticks set value 100
data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.remaining_seconds set value 5
scoreboard players set #n15_moon_started_now race_state 1
tellraw @a [{"text":"SHOOT DOWN THE MOON · ","color":"red","bold":true},{"text":"5 seconds. Kill the respawned Ender Dragon now!","color":"gold","bold":true}]
