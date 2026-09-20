data modify storage advancement_race:match rules.cooperative set from storage advancement_race:config cooperative
data modify storage advancement_race:match cooperative set value {team_points:0,duration_ticks:0,vanilla_completed:0,challenge_completed:0,completed:[],events:[],challenges:{supply:{status:"active",iron:0,gold:0,diamond:0,obsidian:0},relay:{status:"idle",remaining_seconds:0,attempts:0,zombie:0b,skeleton:0b,creeper:0b}}}
data modify storage advancement_race:match cooperative.challenges.supply.iron_target set from storage advancement_race:match rules.cooperative.supply.iron_target
data modify storage advancement_race:match cooperative.challenges.supply.gold_target set from storage advancement_race:match rules.cooperative.supply.gold_target
data modify storage advancement_race:match cooperative.challenges.supply.diamond_target set from storage advancement_race:match rules.cooperative.supply.diamond_target
data modify storage advancement_race:match cooperative.challenges.supply.obsidian_target set from storage advancement_race:match rules.cooperative.supply.obsidian_target
execute store result score #coop_roster_count race_state run data get storage advancement_race:match participants
execute store result storage advancement_race:match cooperative.roster_count int 1 run scoreboard players get #coop_roster_count race_state
function advancement_race:cooperative/calculate_shrink_rate
scoreboard players set #coop_team_points race_state 0
scoreboard players set #coop_duration_ticks race_state 0
scoreboard players set #coop_vanilla_completed race_state 0
scoreboard players set #coop_challenge_completed race_state 0
scoreboard players set #coop_tick race_state 0
execute store result score #coop_border_size race_state run data get storage advancement_race:match rules.cooperative.border.initial_size
scoreboard players operation #coop_border_milli race_state = #coop_border_size race_state
scoreboard players operation #coop_border_milli race_state *= #coop_thousand race_state
execute store result storage advancement_race:match cooperative.border.size_milli int 1 run scoreboard players get #coop_border_milli race_state
function advancement_race:cooperative/border/capture
function advancement_race:cooperative/border/sync
tellraw @a [{"text":"Cooperative Border","color":"aqua","bold":true},{"text":" | The Border is shrinking. Team-first completions expand it once.","color":"gray","bold":false}]
