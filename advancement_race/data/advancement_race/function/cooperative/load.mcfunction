function advancement_race:cooperative/configure_defaults
function advancement_race:cooperative/configure_v11_generated
execute if data storage advancement_race:match {status:"idle",prepared:1b,mode:"cooperative_border"} run function advancement_race:cooperative/setup/ensure_defaults
scoreboard players set #coop_thousand race_state 1000
scoreboard players add #coop_tick race_state 0
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} run function advancement_race:cooperative/recover
