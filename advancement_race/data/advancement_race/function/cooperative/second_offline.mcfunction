scoreboard players set #coop_tick race_state 0
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} run function advancement_race:cooperative/border/tick
