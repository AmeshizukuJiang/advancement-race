execute unless data storage advancement_race:match {status:"active"} run tellraw @s [{"text":"Live Standings are available only during an active match.","color":"red"}]
execute if data storage advancement_race:match {status:"active"} run function advancement_race:status/calculate
execute if data storage advancement_race:match {status:"active"} if data storage advancement_race:runtime {status:{status:"ready"}} run function advancement_race:standings/copy_from_status
execute if data storage advancement_race:match {status:"active"} if data storage advancement_race:runtime {standings:{status:"ready",mode:"live"}} run function advancement_race:standings_book/open
execute if data storage advancement_race:match {status:"active"} unless data storage advancement_race:runtime {standings:{status:"ready",mode:"live"}} run tellraw @s [{"text":"Live Standings are not available for this match.","color":"red"}]
