$data modify storage advancement_race:runtime result_book_work.sequence set from storage advancement_race:runtime result_book.events[$(page_index)].sequence
$data modify storage advancement_race:runtime result_book_work.advancement set from storage advancement_race:runtime result_book.events[$(page_index)].advancement
$data modify storage advancement_race:runtime result_book_work.place set from storage advancement_race:runtime result_book.events[$(page_index)].place
$data modify storage advancement_race:runtime result_book_work.points set from storage advancement_race:runtime result_book.events[$(page_index)].points
function advancement_race:result_book/append_event_page with storage advancement_race:runtime result_book_work
