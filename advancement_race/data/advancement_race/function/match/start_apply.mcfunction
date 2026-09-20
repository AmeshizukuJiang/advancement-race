execute store result score #next_match_id race_state run data get storage advancement_race:state next_match_id 1
scoreboard players add #next_match_id race_state 1
execute store result storage advancement_race:state next_match_id int 1 run scoreboard players get #next_match_id race_state
execute store result storage advancement_race:match id int 1 run scoreboard players get #next_match_id race_state
data modify storage advancement_race:match status set value "active"
data modify storage advancement_race:match prepared set value 0b
scoreboard players set #match_active race_state 1
execute if data storage advancement_race:match {mode:"cooperative_border"} run function advancement_race:cooperative/start
tellraw @a [{"text":"Advancement Race","color":"gold","bold":true},{"text":" | Match #","color":"gray","bold":false},{"storage":"advancement_race:match","nbt":"id","color":"gold"},{"text":" has started!","color":"green"}]
execute if data storage advancement_race:match {mode:"cooperative_border"} run tellraw @a [{"text":"Mode: ","color":"gray"},{"text":"Cooperative Border","color":"aqua","bold":true},{"text":" — one team, shared race progress.","color":"gray","bold":false}]
tellraw @a [{"text":"Use ","color":"gray"},{"text":"/trigger race_menu","color":"gold","click_event":{"action":"run_command","command":"/trigger race_menu"},"hover_event":{"action":"show_text","value":{"text":"Open the race menu","color":"yellow"}}},{"text":" for Status and Vote End.","color":"gray"}]
