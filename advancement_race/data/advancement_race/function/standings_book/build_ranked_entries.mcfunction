execute if score #standings_book_rank race_state <= #standings_book_count race_state run scoreboard players set #standings_book_scan_index race_state 0
execute if score #standings_book_rank race_state <= #standings_book_count race_state run data modify storage advancement_race:runtime standings_book_work.participant_index set value 0
execute if score #standings_book_rank race_state <= #standings_book_count race_state run function advancement_race:standings_book/scan_participants with storage advancement_race:runtime standings_book_work
execute if score #standings_book_rank race_state <= #standings_book_count race_state run scoreboard players add #standings_book_rank race_state 1
execute if score #standings_book_rank race_state <= #standings_book_count race_state run execute store result storage advancement_race:runtime standings_book_work.rank int 1 run scoreboard players get #standings_book_rank race_state
execute if score #standings_book_rank race_state <= #standings_book_count race_state run function advancement_race:standings_book/build_ranked_entries with storage advancement_race:runtime standings_book_work
