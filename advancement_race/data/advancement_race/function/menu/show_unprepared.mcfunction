tellraw @s [{"text":"Advancement Race\n","color":"gold","bold":true},{"text":"No lobby is prepared.","color":"yellow","bold":false}]
tellraw @s [{"text":"Next: ask the host to prepare a new match.","color":"gray"}]
execute if data storage advancement_race:history matches[-1] run function advancement_race:menu/show_latest_result_action
execute if data storage advancement_race:history matches[0] run function advancement_race:menu/show_previous_races_action
