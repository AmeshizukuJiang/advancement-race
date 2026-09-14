function advancement_race:browser/session/begin
execute store result score #history_count race_state run data get storage advancement_race:history matches
execute store result score #history_page race_state run data get storage advancement_race:runtime browser_work.session.page
scoreboard players operation #history_last_page race_state = #history_count race_state
scoreboard players remove #history_last_page race_state 1
scoreboard players set #history_page_size race_state 8
scoreboard players operation #history_last_page race_state /= #history_page_size race_state
scoreboard players set #history_page_valid race_state 1
execute unless score #history_page race_state matches 0.. run scoreboard players set #history_page_valid race_state 0
execute if score #history_page race_state > #history_last_page race_state run scoreboard players set #history_page_valid race_state 0
execute if score #history_page_valid race_state matches 1 run function advancement_race:history_book/prepare
execute unless score #history_page_valid race_state matches 1 run function advancement_race:browser/stale
