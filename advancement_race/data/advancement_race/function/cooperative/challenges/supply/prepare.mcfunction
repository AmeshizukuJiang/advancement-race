execute if data storage advancement_race:match cooperative.challenges.supply{status:"completed"} run tellraw @s [{"text":"Four-Realm Supply Line is already complete.","color":"yellow"}]
$execute unless data storage advancement_race:match cooperative.challenges.supply{status:"completed"} store result score #supply_progress race_state run data get storage advancement_race:match cooperative.challenges.supply.$(field)
$execute unless data storage advancement_race:match cooperative.challenges.supply{status:"completed"} store result score #supply_target race_state run data get storage advancement_race:match cooperative.challenges.supply.$(target_field)
scoreboard players operation #supply_remaining race_state = #supply_target race_state
scoreboard players operation #supply_remaining race_state -= #supply_progress race_state
$execute unless data storage advancement_race:match cooperative.challenges.supply{status:"completed"} store result score #supply_available race_state run clear @s $(item) 0
scoreboard players operation #supply_amount race_state = #supply_available race_state
execute if score #supply_amount race_state > #supply_remaining race_state run scoreboard players operation #supply_amount race_state = #supply_remaining race_state
$execute unless data storage advancement_race:match cooperative.challenges.supply{status:"completed"} if score #supply_amount race_state matches ..0 run tellraw @s [{"text":"No required $(label) available to submit.","color":"yellow"}]
$execute unless data storage advancement_race:match cooperative.challenges.supply{status:"completed"} if score #supply_amount race_state matches 1.. run data modify storage advancement_race:runtime supply_work set value {item:"$(item)",field:"$(field)",label:"$(label)"}
execute unless data storage advancement_race:match cooperative.challenges.supply{status:"completed"} if score #supply_amount race_state matches 1.. store result storage advancement_race:runtime supply_work.amount int 1 run scoreboard players get #supply_amount race_state
execute unless data storage advancement_race:match cooperative.challenges.supply{status:"completed"} if score #supply_amount race_state matches 1.. run function advancement_race:cooperative/challenges/supply/consume with storage advancement_race:runtime supply_work
