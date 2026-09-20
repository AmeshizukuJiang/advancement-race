execute store result score #coop_shrink_milli race_state run data get storage advancement_race:match cooperative.border.shrink_milli_per_second
scoreboard players operation #coop_border_milli race_state -= #coop_shrink_milli race_state
execute store result score #coop_min_border race_state run data get storage advancement_race:match rules.cooperative.border.minimum_size
scoreboard players operation #coop_min_border race_state *= #coop_thousand race_state
execute if score #coop_border_milli race_state <= #coop_min_border race_state run scoreboard players operation #coop_border_milli race_state = #coop_min_border race_state
execute store result storage advancement_race:match cooperative.border.size_milli int 1 run scoreboard players get #coop_border_milli race_state
function advancement_race:cooperative/border/sync
execute if score #coop_border_milli race_state = #coop_min_border race_state run data modify storage advancement_race:match end_reason set value "border_collapsed"
execute if score #coop_border_milli race_state = #coop_min_border race_state run function advancement_race:match/end_apply
