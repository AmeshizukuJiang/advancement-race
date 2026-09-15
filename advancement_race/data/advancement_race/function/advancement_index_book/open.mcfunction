execute unless data storage advancement_race:runtime advancement_index{status:"ready"} run tellraw @s [{"text":"The Advancement Index is not available.","color":"red"}]
execute if data storage advancement_race:runtime advancement_index{status:"ready"} run function advancement_race:advancement_index_book/prepare
