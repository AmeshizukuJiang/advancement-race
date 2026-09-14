execute unless data storage advancement_race:history matches[-1] run tellraw @s [{"text":"No completed match is available.","color":"red"}]
execute if data storage advancement_race:history matches[-1] run function advancement_race:result/calculate_latest
execute if data storage advancement_race:history matches[-1] if data storage advancement_race:runtime {result:{status:"ready"}} run function advancement_race:result_book/give
execute if data storage advancement_race:history matches[-1] unless data storage advancement_race:runtime {result:{status:"ready"}} run tellraw @s [{"text":"The latest Result Book is not available.","color":"red"}]
