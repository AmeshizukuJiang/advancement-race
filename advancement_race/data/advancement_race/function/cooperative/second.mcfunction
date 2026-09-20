scoreboard players set #coop_tick race_state 0
scoreboard players add #coop_duration_ticks race_state 20
execute store result storage advancement_race:match cooperative.duration_ticks int 1 run scoreboard players get #coop_duration_ticks race_state
execute if data storage advancement_race:match cooperative.challenges.relay{status:"active"} run function advancement_race:cooperative/challenges/relay/tick
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} run function advancement_race:cooperative/border/tick
