data modify storage advancement_race:runtime status.match_id set from storage advancement_race:match id
data modify storage advancement_race:runtime status.events set from storage advancement_race:match events
data modify storage advancement_race:runtime status.participants set from storage advancement_race:match participants
scoreboard players set #status_participant_index race_state 0
data modify storage advancement_race:runtime status_work.participant_index set value 0
function advancement_race:status/initialize_participants with storage advancement_race:runtime status_work
scoreboard players set #status_event_index race_state 0
data modify storage advancement_race:runtime status_work.event_index set value 0
function advancement_race:status/accumulate_events with storage advancement_race:runtime status_work
scoreboard players set #status_participant_index race_state 0
data modify storage advancement_race:runtime status_work.participant_index set value 0
function advancement_race:status/rank_participants with storage advancement_race:runtime status_work
data modify storage advancement_race:runtime status.status set value "ready"
