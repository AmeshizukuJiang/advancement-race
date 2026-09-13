$execute if data storage advancement_race:runtime result.events[$(event_index)] run function advancement_race:result_book/copy_event_step with storage advancement_race:runtime result_book_work
$execute if data storage advancement_race:runtime result.events[$(event_index)] run scoreboard players add #result_book_event_index race_state 1
$execute if data storage advancement_race:runtime result.events[$(event_index)] run execute store result storage advancement_race:runtime result_book_work.event_index int 1 run scoreboard players get #result_book_event_index race_state
$execute if data storage advancement_race:runtime result.events[$(event_index)] run function advancement_race:result_book/copy_events_loop with storage advancement_race:runtime result_book_work
