execute unless data storage advancement_race:match {status:"active"} run tellraw @s [{"text":"Cannot end: no active match is running."}]
execute if data storage advancement_race:match {status:"active"} unless data storage advancement_race:match end_reason run data modify storage advancement_race:match end_reason set value "manual"
execute if data storage advancement_race:match {status:"active"} run function advancement_race:match/end_apply
