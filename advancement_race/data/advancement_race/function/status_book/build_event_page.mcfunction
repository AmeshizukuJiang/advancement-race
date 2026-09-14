$data modify storage advancement_race:runtime status_book_work.sequence set from storage advancement_race:runtime status_book.events[$(page_index)].sequence
$data modify storage advancement_race:runtime status_book_work.advancement set from storage advancement_race:runtime status_book.events[$(page_index)].advancement
$data modify storage advancement_race:runtime status_book_work.place set from storage advancement_race:runtime status_book.events[$(page_index)].place
$data modify storage advancement_race:runtime status_book_work.points set from storage advancement_race:runtime status_book.events[$(page_index)].points
data modify storage advancement_race:runtime presentation set value {}
data modify storage advancement_race:runtime presentation.advancement set from storage advancement_race:runtime status_book_work.advancement
function advancement_race:presentation/resolve_advancement_title
data modify storage advancement_race:runtime status_book_work.title_translate set from storage advancement_race:runtime presentation.title_translate
execute if score #status_book_page_slot race_state matches 0 run function advancement_race:status_book/append_event_page with storage advancement_race:runtime status_book_work
execute if score #status_book_page_slot race_state matches 1 run function advancement_race:status_book/append_event_to_page with storage advancement_race:runtime status_book_work
scoreboard players add #status_book_page_slot race_state 1
execute if score #status_book_page_slot race_state matches 2 run scoreboard players set #status_book_page_slot race_state 0
