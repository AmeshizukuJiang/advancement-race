data modify storage advancement_race:runtime status_book.player_name set from storage advancement_race:runtime status_book.participant.name
data modify storage advancement_race:runtime status_book.points set from storage advancement_race:runtime status_book.participant.points
data modify storage advancement_race:runtime status_book.rank set from storage advancement_race:runtime status_book.participant.rank
data modify storage advancement_race:runtime status_book.completed set from storage advancement_race:runtime status_book.participant.completed
data modify storage advancement_race:runtime status_book_work.player_uuid set from storage advancement_race:runtime status_book.participant.uuid
scoreboard players set #status_book_event_index race_state 0
data modify storage advancement_race:runtime status_book_work.event_index set value 0
function advancement_race:status_book/copy_events_loop with storage advancement_race:runtime status_book_work
