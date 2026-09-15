execute if score #standings_book_entries_on_page race_state matches 6.. run function advancement_race:standings_book/next_page with storage advancement_race:runtime standings_book_work
data modify storage advancement_race:runtime standings_book_work.name set from storage advancement_race:runtime standings_book_work.candidate.name
data modify storage advancement_race:runtime standings_book_work.points set from storage advancement_race:runtime standings_book_work.candidate.points
data modify storage advancement_race:runtime standings_book_work.completed set from storage advancement_race:runtime standings_book_work.candidate.completed
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"participant_detail",participant_index:0}
data modify storage advancement_race:runtime browser_work.pending_action.participant_index set from storage advancement_race:runtime standings_book_work.participant_index
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime standings_book_work.action_code set from storage advancement_race:runtime browser_work.action_code
execute if score #standings_book_has_score race_state matches 1.. run function advancement_race:standings_book/append_ranked_entry with storage advancement_race:runtime standings_book_work
execute unless score #standings_book_has_score race_state matches 1.. run function advancement_race:standings_book/append_no_score_entry with storage advancement_race:runtime standings_book_work
scoreboard players add #standings_book_entries_on_page race_state 1
