$data modify storage advancement_race:runtime standings_book_work.candidate set from storage advancement_race:runtime standings_book.participants[$(detect_index)]
execute store result score #standings_book_candidate_points race_state run data get storage advancement_race:runtime standings_book_work.candidate.points
execute if score #standings_book_candidate_points race_state matches 1.. run scoreboard players set #standings_book_has_score race_state 1
