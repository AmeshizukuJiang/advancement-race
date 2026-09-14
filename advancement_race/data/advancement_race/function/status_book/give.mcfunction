execute unless data storage advancement_race:runtime {status:{status:"ready"}} run tellraw @s [{"text":"No current Status Book is available.","color":"red"}]
execute if data storage advancement_race:runtime {status:{status:"ready"}} run function advancement_race:status_book/prepare
