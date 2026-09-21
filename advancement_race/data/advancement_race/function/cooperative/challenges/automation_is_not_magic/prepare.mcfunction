$execute store result score #automation_progress race_state run data get storage advancement_race:match cooperative.challenges.automation_is_not_magic.$(field)
$execute store result score #automation_target race_state run data get storage advancement_race:match cooperative.challenges.automation_is_not_magic.$(target_field)
scoreboard players operation #automation_remaining race_state = #automation_target race_state
scoreboard players operation #automation_remaining race_state -= #automation_progress race_state
$execute store result score #automation_available race_state run clear @s $(item) 0
scoreboard players operation #automation_amount race_state = #automation_available race_state
execute if score #automation_amount race_state > #automation_remaining race_state run scoreboard players operation #automation_amount race_state = #automation_remaining race_state
$execute if score #automation_amount race_state matches ..0 run tellraw @s [{"text":"No required $(label) available to submit.","color":"yellow"}]
$execute if score #automation_amount race_state matches 1.. run data modify storage advancement_race:runtime automation_work set value {item:"$(item)",field:"$(field)",label:"$(label)"}
execute if score #automation_amount race_state matches 1.. store result storage advancement_race:runtime automation_work.amount int 1 run scoreboard players get #automation_amount race_state
execute if score #automation_amount race_state matches 1.. run function advancement_race:cooperative/challenges/automation_is_not_magic/consume with storage advancement_race:runtime automation_work
