scoreboard players operation #history_page_number race_state = #history_page race_state
scoreboard players add #history_page_number race_state 1
scoreboard players operation #history_total_pages race_state = #history_last_page race_state
scoreboard players add #history_total_pages race_state 1
execute store result storage advancement_race:runtime browser_work.page_number int 1 run scoreboard players get #history_page_number race_state
execute store result storage advancement_race:runtime browser_work.total_pages int 1 run scoreboard players get #history_total_pages race_state
function advancement_race:history_book/build_header with storage advancement_race:runtime browser_work
scoreboard players operation #history_offset race_state = #history_page race_state
scoreboard players operation #history_offset race_state *= #history_page_size race_state
scoreboard players operation #history_index race_state = #history_count race_state
scoreboard players remove #history_index race_state 1
scoreboard players operation #history_index race_state -= #history_offset race_state
scoreboard players set #history_row race_state 0
execute store result storage advancement_race:runtime browser_work.history_index int 1 run scoreboard players get #history_index race_state
function advancement_race:history_book/build_entries with storage advancement_race:runtime browser_work
function advancement_race:history_book/build_navigation
function advancement_race:browser/session/finalize
function advancement_race:history_book/give_item with storage advancement_race:runtime browser_work
