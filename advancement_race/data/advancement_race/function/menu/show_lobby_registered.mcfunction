tellraw @s [{"text":"Advancement Race\n","color":"gold","bold":true},{"text":"Lobby Ready","color":"green","bold":false},{"text":" | Registered","color":"green"}]
tellraw @s [{"text":"Next: wait for the host to start the match.","color":"gray"}]
tellraw @s [{"text":"[Open Lobby Book]","color":"green","bold":true,"click_event":{"action":"run_command","command":"/trigger race_menu set 2"},"hover_event":{"action":"show_text","value":{"text":"View the current roster","color":"yellow"}}}]
execute if data storage advancement_race:history matches[-1] run function advancement_race:menu/show_latest_result_action
execute if data storage advancement_race:history matches[0] run function advancement_race:menu/show_previous_races_action
