$execute store result score #supply_removed race_state run clear @s $(item) $(amount)
scoreboard players operation #supply_progress race_state += #supply_removed race_state
$execute store result storage advancement_race:match cooperative.challenges.supply.$(field) int 1 run scoreboard players get #supply_progress race_state
$tellraw @s [{"text":"Submitted ","color":"green"},{"score":{"name":"#supply_removed","objective":"race_state"},"color":"yellow"},{"text":" $(label) to the team supply line.","color":"gray"}]
function advancement_race:cooperative/challenges/supply/check
