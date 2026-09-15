execute unless data storage advancement_race:runtime standings{status:"ready"} run tellraw @s [{"text":"Standings are not available.","color":"red"}]
execute if data storage advancement_race:runtime standings{status:"ready"} run function advancement_race:standings_book/prepare
