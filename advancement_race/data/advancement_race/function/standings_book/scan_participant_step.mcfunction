$data modify storage advancement_race:runtime standings_book_work.candidate set from storage advancement_race:runtime standings_book.participants[$(participant_index)]
execute store result score #standings_book_candidate_rank race_state run data get storage advancement_race:runtime standings_book_work.candidate.rank
execute if score #standings_book_candidate_rank race_state = #standings_book_rank race_state run function advancement_race:standings_book/append_entry with storage advancement_race:runtime standings_book_work
