scoreboard players add #stone_age_count race_state 1
scoreboard players operation @s race_place = #stone_age_count race_state
scoreboard players set @s race_award 20
execute if score @s race_place matches 1 run scoreboard players set @s race_award 100
execute if score @s race_place matches 2 run scoreboard players set @s race_award 80
execute if score @s race_place matches 3 run scoreboard players set @s race_award 60
execute if score @s race_place matches 4 run scoreboard players set @s race_award 40
scoreboard players operation @s race_points += @s race_award
tellraw @a [{"selector":"@s"},{"text":" completed "},{"translate":"advancements.story.mine_stone.title"},{"text":" — place "},{"score":{"name":"@s","objective":"race_place"}},{"text":"; earned "},{"score":{"name":"@s","objective":"race_award"}},{"text":" points."}]
title @a actionbar [{"selector":"@s"},{"text":" completed "},{"translate":"advancements.story.mine_stone.title"},{"text":" — place "},{"score":{"name":"@s","objective":"race_place"}},{"text":"; earned "},{"score":{"name":"@s","objective":"race_award"}},{"text":" points."}]
function advancement_race:events/record_stone_age
