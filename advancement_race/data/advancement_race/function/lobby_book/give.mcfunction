execute if data storage advancement_race:match {status:"idle",prepared:0b} run tellraw @s [{"text":"No lobby is prepared. Ask the host to prepare a new match.","color":"red"}]
execute unless data storage advancement_race:match {status:"idle"} run tellraw @s [{"text":"The lobby is not currently open.","color":"red"}]
execute if data storage advancement_race:match {status:"idle",prepared:1b} unless data storage advancement_race:match participants[0] run function advancement_race:lobby_book/give_empty
execute if data storage advancement_race:match {status:"idle",prepared:1b} if data storage advancement_race:match participants[0] run function advancement_race:lobby_book/prepare
