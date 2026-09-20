scoreboard players set #supply_complete race_state 1
execute store result score #supply_progress race_state run data get storage advancement_race:match cooperative.challenges.supply.iron
execute store result score #supply_target race_state run data get storage advancement_race:match cooperative.challenges.supply.iron_target
execute unless score #supply_progress race_state >= #supply_target race_state run scoreboard players set #supply_complete race_state 0
execute store result score #supply_progress race_state run data get storage advancement_race:match cooperative.challenges.supply.gold
execute store result score #supply_target race_state run data get storage advancement_race:match cooperative.challenges.supply.gold_target
execute unless score #supply_progress race_state >= #supply_target race_state run scoreboard players set #supply_complete race_state 0
execute store result score #supply_progress race_state run data get storage advancement_race:match cooperative.challenges.supply.diamond
execute store result score #supply_target race_state run data get storage advancement_race:match cooperative.challenges.supply.diamond_target
execute unless score #supply_progress race_state >= #supply_target race_state run scoreboard players set #supply_complete race_state 0
execute store result score #supply_progress race_state run data get storage advancement_race:match cooperative.challenges.supply.obsidian
execute store result score #supply_target race_state run data get storage advancement_race:match cooperative.challenges.supply.obsidian_target
execute unless score #supply_progress race_state >= #supply_target race_state run scoreboard players set #supply_complete race_state 0
execute if score #supply_complete race_state matches 1 unless data storage advancement_race:match cooperative.challenges.supply{status:"completed"} run function advancement_race:cooperative/challenges/supply/complete
