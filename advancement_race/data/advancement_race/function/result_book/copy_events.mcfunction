data modify storage advancement_race:runtime result_book.player_name set from storage advancement_race:runtime result_book.participant.name
data modify storage advancement_race:runtime result_book.points set from storage advancement_race:runtime result_book.participant.points
data modify storage advancement_race:runtime result_book.rank set from storage advancement_race:runtime result_book.participant.rank
data modify storage advancement_race:runtime result_book.completed set from storage advancement_race:runtime result_book.participant.completed
execute store result score #result_book_participant_count race_state run data get storage advancement_race:runtime result.participants
execute store result storage advancement_race:runtime result_book.participant_count int 1 run scoreboard players get #result_book_participant_count race_state
data modify storage advancement_race:runtime result_book_work.player_uuid set from storage advancement_race:runtime result_book.participant.uuid
scoreboard players set #result_book_event_index race_state 0
data modify storage advancement_race:runtime result_book_work.event_index set value 0
function advancement_race:result_book/copy_events_loop with storage advancement_race:runtime result_book_work
