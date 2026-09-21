data modify storage advancement_race:match rules.cooperative set from storage advancement_race:config cooperative
function advancement_race:cooperative/setup/ensure_defaults
function advancement_race:cooperative/setup/snapshot
function advancement_race:cooperative/rules/apply_difficulty
function advancement_race:cooperative/rules/apply_survival_world
function advancement_race:cooperative/rules/apply_independent_world
execute as @a[scores={race_participant=0..}] run function advancement_race:cooperative/rules/apply_survival_player
execute as @a[scores={race_participant=0..}] run scoreboard players operation @s race_death_seen = @s race_deaths
data modify storage advancement_race:match cooperative set value {team_points:0,duration_ticks:0,vanilla_completed:0,challenge_completed:0,completed:[],events:[],challenges:{splendid_as_summer_flowers:{status:"locked"},injustice_in_june:{status:"locked"},end_fishing:{status:"locked"},fire_and_ice:{status:"locked"},supply:{status:"locked",iron:0,gold:0,diamond:0,obsidian:0},relay:{status:"locked",remaining_seconds:0,attempts:0,zombie:0b,skeleton:0b,creeper:0b,spider:0b,witch:0b,enderman:0b},eternal_slumber:{status:"locked",remaining_seconds:0,attempts:0,overworld:0b,nether:0b,end:0b},ecological_restoration:{status:"locked",remaining_seconds:0,attempts:0,wheat:0b,beetroot:0b,carrot:0b,potato:0b,pumpkin:0b,melon:0b,torchflower:0b,pitcher:0b,cocoa:0b,nether_wart:0b},something_is_wrong:{status:"locked",remaining_seconds:0,attempts:0,fortress_barter:0b,bastion_blaze:0b},sleep_above_clouds:{status:"locked"},out_of_climate:{status:"locked"},relay_ii:{status:"locked",remaining_seconds:0,attempts:0,drowned:0b,blaze:0b,enderman:0b,pillager:0b,phantom:0b,slime:0b},automation_is_not_magic:{status:"locked",iron:0,iron_target:64,dried_kelp:0,dried_kelp_target:32,fireworks:0,fireworks_target:64,honey:0,honey_target:8},underwater_furnace:{status:"locked"},into_the_nightmare:{status:"locked"}}}
function advancement_race:cooperative/challenges/initialize_prototype
execute as @a[scores={race_participant=0..}] run function advancement_race:cooperative/challenges/revoke_helpers
execute as @a[scores={race_participant=0..}] run scoreboard players operation @s race_challenge_death_seen = @s race_deaths
scoreboard players set @a[scores={race_participant=0..}] race_cold_strider 0
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
