function advancement_race:result_book/build_summary_page with storage advancement_race:runtime result_book
scoreboard players set #result_book_page_index race_state 0
scoreboard players set #result_book_page_slot race_state 0
data modify storage advancement_race:runtime result_book_work.page_index set value 0
function advancement_race:result_book/build_event_pages with storage advancement_race:runtime result_book_work
data modify storage advancement_race:runtime result_book.status set value "ready"
