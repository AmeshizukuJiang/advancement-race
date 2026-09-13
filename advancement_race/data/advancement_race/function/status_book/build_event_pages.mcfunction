$execute if data storage advancement_race:runtime status_book.events[$(page_index)] run function advancement_race:status_book/build_event_page with storage advancement_race:runtime status_book_work
$execute if data storage advancement_race:runtime status_book.events[$(page_index)] run scoreboard players add #status_book_page_index race_state 1
$execute if data storage advancement_race:runtime status_book.events[$(page_index)] run execute store result storage advancement_race:runtime status_book_work.page_index int 1 run scoreboard players get #status_book_page_index race_state
$execute if data storage advancement_race:runtime status_book.events[$(page_index)] run function advancement_race:status_book/build_event_pages with storage advancement_race:runtime status_book_work
