$data modify storage advancement_race:runtime info_center_work.roster_entry set from storage advancement_race:runtime info_center.participants[$(roster_index)]
data modify storage advancement_race:runtime info_center_work.roster_name set from storage advancement_race:runtime info_center_work.roster_entry.name
scoreboard players operation #info_center_roster_number race_state = #info_center_roster_index race_state
scoreboard players add #info_center_roster_number race_state 1
execute store result storage advancement_race:runtime info_center_work.roster_number int 1 run scoreboard players get #info_center_roster_number race_state
function advancement_race:info_center/append_roster_line with storage advancement_race:runtime info_center_work
