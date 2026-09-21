execute unless data storage advancement_race:match {status:"idle",prepared:1b} run tellraw @s [{"text":"Game mode can only be changed in a prepared lobby.","color":"red"}]
execute if data storage advancement_race:match {status:"idle",prepared:1b} run data modify storage advancement_race:match mode set value "competitive"
execute if data storage advancement_race:match {status:"idle",prepared:1b} run data remove storage advancement_race:match cooperative
execute if data storage advancement_race:match {status:"idle",prepared:1b} run data remove storage advancement_race:match rules
execute if data storage advancement_race:match {status:"idle",prepared:1b} run data remove storage advancement_race:match setup
execute if data storage advancement_race:match {status:"idle",prepared:1b} run tellraw @s [{"text":"Selected mode: ","color":"gray"},{"text":"Competitive","color":"gold","bold":true}]
