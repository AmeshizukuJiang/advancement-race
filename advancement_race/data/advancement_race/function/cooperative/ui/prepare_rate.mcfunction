execute store result score #coop_ui_shrink_milli race_state run data get storage advancement_race:runtime info_center.shrink_milli
scoreboard players set #coop_ui_thousand race_state 1000
scoreboard players set #coop_ui_hundred race_state 100
scoreboard players operation #coop_ui_shrink_whole race_state = #coop_ui_shrink_milli race_state
scoreboard players operation #coop_ui_shrink_whole race_state /= #coop_ui_thousand race_state
scoreboard players operation #coop_ui_shrink_tenths race_state = #coop_ui_shrink_milli race_state
scoreboard players operation #coop_ui_shrink_tenths race_state %= #coop_ui_thousand race_state
scoreboard players operation #coop_ui_shrink_tenths race_state /= #coop_ui_hundred race_state
execute store result storage advancement_race:runtime info_center.shrink_whole int 1 run scoreboard players get #coop_ui_shrink_whole race_state
execute store result storage advancement_race:runtime info_center.shrink_tenths int 1 run scoreboard players get #coop_ui_shrink_tenths race_state
