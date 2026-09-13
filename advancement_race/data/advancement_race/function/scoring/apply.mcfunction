$scoreboard players add $(counter) race_state 1
$scoreboard players operation @s race_place = $(counter) race_state
$scoreboard players set @s race_award $(base_score)
scoreboard players set #score_multiplier race_state 20
execute if score @s race_place matches 1 run scoreboard players set #score_multiplier race_state 100
execute if score @s race_place matches 2 run scoreboard players set #score_multiplier race_state 80
execute if score @s race_place matches 3 run scoreboard players set #score_multiplier race_state 60
execute if score @s race_place matches 4 run scoreboard players set #score_multiplier race_state 40
scoreboard players operation @s race_award *= #score_multiplier race_state
scoreboard players operation @s race_award /= #score_percent race_state
scoreboard players operation @s race_points += @s race_award
$tellraw @a [{"selector":"@s"},{"text":" completed "},{"translate":"$(title)"},{"text":" — place "},{"score":{"name":"@s","objective":"race_place"}},{"text":"; earned "},{"score":{"name":"@s","objective":"race_award"}},{"text":" points."}]
$title @a actionbar [{"selector":"@s"},{"text":" completed "},{"translate":"$(title)"},{"text":" — place "},{"score":{"name":"@s","objective":"race_place"}},{"text":"; earned "},{"score":{"name":"@s","objective":"race_award"}},{"text":" points."}]
$data modify storage advancement_race:runtime advancement set value "$(advancement)"
function advancement_race:events/record_event
