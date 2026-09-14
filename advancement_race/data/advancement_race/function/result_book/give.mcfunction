execute unless data storage advancement_race:runtime {result:{status:"ready"}} run tellraw @s [{"text":"No current Result Book is available.","color":"red"}]
execute if data storage advancement_race:runtime {result:{status:"ready"}} run function advancement_race:result_book/prepare
