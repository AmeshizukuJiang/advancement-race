execute if data storage advancement_race:runtime info_center{source:{kind:"current"}} run data modify storage advancement_race:runtime info_center.standings_participants set from storage advancement_race:runtime status.participants
execute if data storage advancement_race:runtime info_center{source:{kind:"history"}} run data modify storage advancement_race:runtime info_center.standings_participants set from storage advancement_race:runtime result.participants
data modify storage advancement_race:runtime info_center.standings_label set value "Live Standings"
execute if data storage advancement_race:runtime info_center{source:{kind:"history"}} run data modify storage advancement_race:runtime info_center.standings_label set value "Final Standings"
execute store result score #info_center_standings_count race_state run data get storage advancement_race:runtime info_center.standings_participants
execute store result score #info_center_page_count race_state run data get storage advancement_race:runtime info_center.pages
scoreboard players add #info_center_page_count race_state 1
execute store result storage advancement_race:runtime info_center.standings_page int 1 run scoreboard players get #info_center_page_count race_state
scoreboard players set #info_center_standings_entries race_state 0
scoreboard players set #info_center_standings_page_number race_state 1
data modify storage advancement_race:runtime info_center_standings_work set value {participant_index:0,rank:1,page_number:1}
data modify storage advancement_race:runtime info_center_standings_work.standings_label set from storage advancement_race:runtime info_center.standings_label
function advancement_race:info_center/standings/append_page with storage advancement_race:runtime info_center_standings_work
scoreboard players set #info_center_standings_rank race_state 1
function advancement_race:info_center/standings/build_ranks with storage advancement_race:runtime info_center_standings_work
