execute store result score #status_book_points race_state run data get storage advancement_race:runtime status_book.points
execute if score #status_book_points race_state matches 0 run function advancement_race:status_book/build_summary_no_score with storage advancement_race:runtime status_book
execute unless score #status_book_points race_state matches 0 run function advancement_race:status_book/build_summary_rank with storage advancement_race:runtime status_book
scoreboard players set #status_book_page_index race_state 0
scoreboard players set #status_book_page_slot race_state 0
data modify storage advancement_race:runtime status_book_work.page_index set value 0
function advancement_race:status_book/build_event_pages with storage advancement_race:runtime status_book_work
data modify storage advancement_race:runtime status_book.status set value "ready"
