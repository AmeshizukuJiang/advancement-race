data modify storage advancement_race:runtime result.match_id set from storage advancement_race:runtime result_source.id
data modify storage advancement_race:runtime result.events set from storage advancement_race:runtime result_source.events
data modify storage advancement_race:runtime result.participants set from storage advancement_race:runtime result_source.participants
scoreboard players set #result_participant_index race_state 0
data modify storage advancement_race:runtime result_work.participant_index set value 0
function advancement_race:result/initialize_participants with storage advancement_race:runtime result_work
scoreboard players set #result_event_index race_state 0
data modify storage advancement_race:runtime result_work.event_index set value 0
function advancement_race:result/accumulate_events with storage advancement_race:runtime result_work
scoreboard players set #result_participant_index race_state 0
data modify storage advancement_race:runtime result_work.participant_index set value 0
function advancement_race:result/rank_participants with storage advancement_race:runtime result_work
data modify storage advancement_race:runtime result.status set value "ready"
