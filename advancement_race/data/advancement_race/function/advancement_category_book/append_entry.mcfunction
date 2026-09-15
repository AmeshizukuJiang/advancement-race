execute if score #advancement_category_entries_on_page race_state matches 6.. run function advancement_race:advancement_category_book/next_page
$data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"advancement_results",advancement:"$(advancement)",title_translate:"$(title_translate)"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime advancement_category_work.entry.action_code set from storage advancement_race:runtime browser_work.action_code
function advancement_race:advancement_category_book/append_link with storage advancement_race:runtime advancement_category_work.entry
scoreboard players add #advancement_category_entries_on_page race_state 1
