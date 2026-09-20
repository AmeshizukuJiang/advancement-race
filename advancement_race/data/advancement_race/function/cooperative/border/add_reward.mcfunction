execute store result score #coop_border_delta race_state run data get storage advancement_race:runtime cooperative_completion.border_delta
scoreboard players operation #coop_border_delta race_state *= #coop_thousand race_state
scoreboard players operation #coop_border_milli race_state += #coop_border_delta race_state
execute store result score #coop_max_border race_state run data get storage advancement_race:match rules.cooperative.border.maximum_size
scoreboard players operation #coop_max_border race_state *= #coop_thousand race_state
execute if score #coop_border_milli race_state > #coop_max_border race_state run scoreboard players operation #coop_border_milli race_state = #coop_max_border race_state
execute store result storage advancement_race:match cooperative.border.size_milli int 1 run scoreboard players get #coop_border_milli race_state
function advancement_race:cooperative/border/sync
