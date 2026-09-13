$execute if data storage advancement_race:runtime status.events[$(event_index)] run function advancement_race:status/accumulate_event with storage advancement_race:runtime status_work
$execute if data storage advancement_race:runtime status.events[$(event_index)] run scoreboard players add #status_event_index race_state 1
$execute if data storage advancement_race:runtime status.events[$(event_index)] run execute store result storage advancement_race:runtime status_work.event_index int 1 run scoreboard players get #status_event_index race_state
$execute if data storage advancement_race:runtime status.events[$(event_index)] run function advancement_race:status/accumulate_events with storage advancement_race:runtime status_work
