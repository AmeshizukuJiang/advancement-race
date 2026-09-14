scoreboard players set #browser_page_valid race_state 0
scoreboard players set #browser_requested_page race_state -1
execute if data storage advancement_race:runtime browser_work{session:{view:"history"},action:{kind:"history_page"}} if data storage advancement_race:runtime browser_work.action.page run execute store result score #browser_requested_page race_state run data get storage advancement_race:runtime browser_work.action.page
execute if data storage advancement_race:runtime browser_work{session:{view:"history"},action:{kind:"history_page"}} if score #browser_requested_page race_state matches 0.. run scoreboard players set #browser_page_valid race_state 1
execute store result score #browser_history_count race_state run data get storage advancement_race:history matches
execute unless score #browser_history_count race_state matches 1.. run scoreboard players set #browser_page_valid race_state 0
scoreboard players operation #browser_last_page race_state = #browser_history_count race_state
scoreboard players remove #browser_last_page race_state 1
scoreboard players set #browser_page_size race_state 8
scoreboard players operation #browser_last_page race_state /= #browser_page_size race_state
execute if score #browser_requested_page race_state > #browser_last_page race_state run scoreboard players set #browser_page_valid race_state 0
execute if score #browser_page_valid race_state matches 1 run scoreboard players set #browser_dispatched race_state 1
execute if score #browser_page_valid race_state matches 1 run data modify storage advancement_race:runtime browser_request set value {view:"history",page:0}
execute if score #browser_page_valid race_state matches 1 run execute store result storage advancement_race:runtime browser_request.page int 1 run scoreboard players get #browser_requested_page race_state
execute if score #browser_page_valid race_state matches 1 run function advancement_race:history_book/open_page
