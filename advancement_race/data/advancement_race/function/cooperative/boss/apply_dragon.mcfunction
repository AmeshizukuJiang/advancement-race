$attribute @s minecraft:max_health base set $(ender_dragon_max_health)
$data modify entity @s Health set value $(ender_dragon_max_health)f
tag @s add advancement_race_boss_modified
$tag @s add advancement_race_boss_$(key)
