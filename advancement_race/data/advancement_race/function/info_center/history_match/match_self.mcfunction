$execute if data storage advancement_race:runtime {info_center_history_work:{player_uuid:$(candidate_uuid)}} run scoreboard players set #info_center_participating race_state 1
$execute if data storage advancement_race:runtime {info_center_history_work:{player_uuid:$(candidate_uuid)}} run data modify storage advancement_race:runtime info_center.registered set value 1b
$execute if data storage advancement_race:runtime {info_center_history_work:{player_uuid:$(candidate_uuid)}} run data modify storage advancement_race:runtime info_center.self set from storage advancement_race:runtime info_center_history_work.candidate
$execute if data storage advancement_race:runtime {info_center_history_work:{player_uuid:$(candidate_uuid)}} run function advancement_race:info_center/history_match/copy_self
