function advancement_race:cooperative/configure_defaults
scoreboard players set #coop_thousand race_state 1000
scoreboard players add #coop_tick race_state 0
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} run function advancement_race:cooperative/recover
