scoreboard players set #info_center_roster_index race_state 0
data modify storage advancement_race:runtime info_center_work set value {roster_index:0}
function advancement_race:info_center/append_roster_loop with storage advancement_race:runtime info_center_work
