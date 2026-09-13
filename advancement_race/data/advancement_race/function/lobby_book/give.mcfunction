execute if data storage advancement_race:match {status:"idle",prepared:0b} run tellraw @s [{"text":"Cannot create lobby book: reset the match to prepare the lobby."}]
execute unless data storage advancement_race:match {status:"idle"} run tellraw @s [{"text":"Cannot create lobby book: the lobby is not currently open."}]
execute if data storage advancement_race:match {status:"idle",prepared:1b} unless data storage advancement_race:match participants[0] run function advancement_race:lobby_book/give_empty
execute if data storage advancement_race:match {status:"idle",prepared:1b} if data storage advancement_race:match participants[0] run function advancement_race:lobby_book/prepare
