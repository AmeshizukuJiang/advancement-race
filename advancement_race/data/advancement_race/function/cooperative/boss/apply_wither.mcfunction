$attribute @s minecraft:max_health base set $(wither_max_health)
$data modify entity @s Health set value $(wither_max_health)f
tag @s add advancement_race_boss_modified
$tag @s add advancement_race_boss_$(key)
