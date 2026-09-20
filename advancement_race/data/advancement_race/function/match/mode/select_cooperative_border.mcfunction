execute unless data storage advancement_race:match {status:"idle",prepared:1b} run tellraw @s [{"text":"Game mode can only be changed in a prepared lobby.","color":"red"}]
execute if data storage advancement_race:match {status:"idle",prepared:1b} run data modify storage advancement_race:match mode set value "cooperative_border"
execute if data storage advancement_race:match {status:"idle",prepared:1b} run tellraw @s [{"text":"Selected mode: ","color":"gray"},{"text":"Cooperative Border","color":"aqua","bold":true},{"text":" (experimental prototype)","color":"yellow","bold":false}]
