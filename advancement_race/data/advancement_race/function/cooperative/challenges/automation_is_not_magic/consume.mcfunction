$execute store result score #automation_removed race_state run clear @s $(item) $(amount)
scoreboard players operation #automation_progress race_state += #automation_removed race_state
$execute store result storage advancement_race:match cooperative.challenges.automation_is_not_magic.$(field) int 1 run scoreboard players get #automation_progress race_state
$tellraw @s [{"text":"Submitted ","color":"green"},{"score":{"name":"#automation_removed","objective":"race_state"},"color":"yellow"},{"text":" $(label).","color":"gray"}]
function advancement_race:cooperative/challenges/automation_is_not_magic/check
