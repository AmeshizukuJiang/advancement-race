execute unless data storage advancement_race:match {status:"idle",prepared:1b} run tellraw @s [{"text":"Cannot start: reset the match before starting a new one."}]
execute if data storage advancement_race:match {status:"idle",prepared:1b} unless data storage advancement_race:match participants[0] run tellraw @s [{"text":"Cannot start: register at least one participant first."}]
execute if data storage advancement_race:match {status:"idle",prepared:1b} if data storage advancement_race:match participants[0] run function advancement_race:match/start_apply
