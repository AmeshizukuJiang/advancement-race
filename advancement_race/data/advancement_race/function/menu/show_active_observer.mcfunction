tellraw @s [{"text":"Advancement Race\n","color":"gold","bold":true},{"text":"Match #","color":"gray","bold":false},{"storage":"advancement_race:match","nbt":"id","color":"gold"},{"text":" is in progress.","color":"green"}]
tellraw @s [{"text":"You are not registered for this match. Status and voting are available only to participants.","color":"yellow"}]
execute if data storage advancement_race:history matches[0] run function advancement_race:menu/show_previous_races_action
