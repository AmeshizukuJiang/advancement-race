scoreboard players operation #coop_border_size race_state = #coop_border_milli race_state
scoreboard players operation #coop_border_size race_state /= #coop_thousand race_state
execute if score #coop_border_size race_state matches ..0 run scoreboard players set #coop_border_size race_state 1
execute store result storage advancement_race:match cooperative.border.size int 1 run scoreboard players get #coop_border_size race_state
function advancement_race:cooperative/border/apply with storage advancement_race:match cooperative.border
