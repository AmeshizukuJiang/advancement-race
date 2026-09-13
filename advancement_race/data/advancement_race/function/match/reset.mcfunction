execute if data storage advancement_race:match {status:"active"} run tellraw @s [{"text":"Cannot reset: end the active match first."}]
execute unless data storage advancement_race:match {status:"active"} run function advancement_race:match/reset_apply
