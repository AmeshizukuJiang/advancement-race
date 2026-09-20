execute unless data storage advancement_race:match mode run data modify storage advancement_race:match mode set value "competitive"
execute if data storage advancement_race:match {mode:"cooperative_border"} run function advancement_race:cooperative/end
data modify storage advancement_race:match status set value "ended"
scoreboard players set #match_active race_state 0
data modify storage advancement_race:history matches append from storage advancement_race:match
tellraw @a [{"text":"Advancement Race","color":"gold","bold":true},{"text":" | Match #","color":"gray","bold":false},{"storage":"advancement_race:match","nbt":"id","color":"gold"},{"text":" has ended.","color":"green"}]
tellraw @a [{"text":"Use ","color":"gray"},{"text":"/trigger race_menu","color":"gold","click_event":{"action":"run_command","command":"/trigger race_menu"},"hover_event":{"action":"show_text","value":{"text":"Open the race menu","color":"yellow"}}},{"text":" to open the latest Result Book.","color":"gray"}]
