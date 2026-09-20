execute store result score #coop_shrink_milli race_state run data get storage advancement_race:match rules.cooperative.border.base_shrink_milli_per_second
scoreboard players operation #coop_extra_players race_state = #coop_roster_count race_state
scoreboard players remove #coop_extra_players race_state 4
execute if score #coop_extra_players race_state matches ..0 run scoreboard players set #coop_extra_players race_state 0
execute store result score #coop_extra_rate race_state run data get storage advancement_race:match rules.cooperative.border.extra_player_shrink_milli
scoreboard players operation #coop_extra_rate race_state *= #coop_extra_players race_state
scoreboard players operation #coop_shrink_milli race_state += #coop_extra_rate race_state
execute store result score #coop_max_shrink race_state run data get storage advancement_race:match rules.cooperative.border.maximum_shrink_milli_per_second
execute if score #coop_shrink_milli race_state > #coop_max_shrink race_state run scoreboard players operation #coop_shrink_milli race_state = #coop_max_shrink race_state
execute store result storage advancement_race:match cooperative.border.shrink_milli_per_second int 1 run scoreboard players get #coop_shrink_milli race_state
