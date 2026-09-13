$execute if data storage advancement_race:runtime result_book.events[$(page_index)] run function advancement_race:result_book/build_event_page with storage advancement_race:runtime result_book_work
$execute if data storage advancement_race:runtime result_book.events[$(page_index)] run scoreboard players add #result_book_page_index race_state 1
$execute if data storage advancement_race:runtime result_book.events[$(page_index)] run execute store result storage advancement_race:runtime result_book_work.page_index int 1 run scoreboard players get #result_book_page_index race_state
$execute if data storage advancement_race:runtime result_book.events[$(page_index)] run function advancement_race:result_book/build_event_pages with storage advancement_race:runtime result_book_work
