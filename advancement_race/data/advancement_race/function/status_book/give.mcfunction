execute unless data storage advancement_race:runtime {status:{status:"ready"}} run tellraw @s [{"text":"Cannot create status book: calculate active match status first."}]
execute if data storage advancement_race:runtime {status:{status:"ready"}} run function advancement_race:status_book/prepare
