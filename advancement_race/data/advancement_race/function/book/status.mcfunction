execute unless data storage advancement_race:match {status:"active"} run tellraw @s [{"text":"No active match is running.","color":"red"}]
execute if data storage advancement_race:match {status:"active"} run function advancement_race:status/calculate
execute if data storage advancement_race:match {status:"active"} if data storage advancement_race:runtime {status:{status:"ready"}} run function advancement_race:status_book/give
execute if data storage advancement_race:match {status:"active"} unless data storage advancement_race:runtime {status:{status:"ready"}} run tellraw @s [{"text":"The Status Book is not available for this match.","color":"red"}]
