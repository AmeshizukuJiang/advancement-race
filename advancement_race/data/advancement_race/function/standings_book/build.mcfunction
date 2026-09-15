data modify storage advancement_race:runtime standings_book.pages set value []
data modify storage advancement_race:runtime standings_book_work set value {participant_index:0,rank:1,page_number:1}
data modify storage advancement_race:runtime standings_book_work.match_id set from storage advancement_race:runtime standings_book.match_id
execute store result score #standings_book_count race_state run data get storage advancement_race:runtime standings_book.participants
scoreboard players set #standings_book_has_score race_state 0
scoreboard players set #standings_book_detect_index race_state 0
data modify storage advancement_race:runtime standings_book_work.detect_index set value 0
function advancement_race:standings_book/detect_scores with storage advancement_race:runtime standings_book_work
scoreboard players set #standings_book_rank race_state 1
scoreboard players set #standings_book_entries_on_page race_state 0
scoreboard players set #standings_book_page_number race_state 1
function advancement_race:standings_book/append_page with storage advancement_race:runtime standings_book_work
function advancement_race:standings_book/build_ranked_entries with storage advancement_race:runtime standings_book_work
data modify storage advancement_race:runtime standings_book.status set value "ready"
