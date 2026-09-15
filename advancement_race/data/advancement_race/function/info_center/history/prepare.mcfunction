data modify storage advancement_race:runtime info_center set value {status:"building",source:{kind:"history_list"},pages:[]}
scoreboard players operation #info_history_page_number race_state = #info_history_page race_state
scoreboard players add #info_history_page_number race_state 1
scoreboard players operation #info_history_total_pages race_state = #info_history_last_page race_state
scoreboard players add #info_history_total_pages race_state 1
execute store result storage advancement_race:runtime info_center_history_work.page_number int 1 run scoreboard players get #info_history_page_number race_state
execute store result storage advancement_race:runtime info_center_history_work.total_pages int 1 run scoreboard players get #info_history_total_pages race_state
function advancement_race:info_center/history/build_header with storage advancement_race:runtime info_center_history_work
scoreboard players operation #info_history_offset race_state = #info_history_page race_state
scoreboard players operation #info_history_offset race_state *= #info_history_page_size race_state
scoreboard players operation #info_history_index race_state = #info_history_count race_state
scoreboard players remove #info_history_index race_state 1
scoreboard players operation #info_history_index race_state -= #info_history_offset race_state
scoreboard players set #info_history_row race_state 0
execute store result storage advancement_race:runtime info_center_history_work.history_index int 1 run scoreboard players get #info_history_index race_state
function advancement_race:info_center/history/build_entries with storage advancement_race:runtime info_center_history_work
function advancement_race:info_center/history/build_navigation
data modify storage advancement_race:runtime info_center.status set value "ready"
function advancement_race:browser/session/finalize
function advancement_race:info_center/deliver
