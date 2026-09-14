tellraw @s [{"text":"Advancement Race\n","color":"gold","bold":true},{"text":"The match has ended.","color":"green","bold":false}]
tellraw @s [{"text":"Next: open the latest Result Book.","color":"gray"}]
execute if data storage advancement_race:history matches[-1] run function advancement_race:menu/show_latest_result_action
execute if data storage advancement_race:history matches[0] run function advancement_race:menu/show_previous_races_action
execute unless data storage advancement_race:history matches[-1] run tellraw @s [{"text":"No completed match is available.","color":"yellow"}]
