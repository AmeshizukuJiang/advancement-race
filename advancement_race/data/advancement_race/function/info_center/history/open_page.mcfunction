function advancement_race:browser/session/begin
execute store result score #info_history_count race_state run data get storage advancement_race:history matches
execute store result score #info_history_page race_state run data get storage advancement_race:runtime browser_work.session.page
scoreboard players operation #info_history_last_page race_state = #info_history_count race_state
scoreboard players remove #info_history_last_page race_state 1
scoreboard players set #info_history_page_size race_state 6
scoreboard players operation #info_history_last_page race_state /= #info_history_page_size race_state
scoreboard players set #info_history_page_valid race_state 1
execute unless score #info_history_page race_state matches 0.. run scoreboard players set #info_history_page_valid race_state 0
execute if score #info_history_page race_state > #info_history_last_page race_state run scoreboard players set #info_history_page_valid race_state 0
execute if score #info_history_page_valid race_state matches 1 run function advancement_race:info_center/history/prepare
execute unless score #info_history_page_valid race_state matches 1 run function advancement_race:browser/stale
