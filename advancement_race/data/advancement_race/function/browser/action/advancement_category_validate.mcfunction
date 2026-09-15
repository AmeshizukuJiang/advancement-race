$execute if data storage advancement_race:history matches[{id:$(match_id),status:"ended"}] run scoreboard players set #browser_dispatched race_state 1
$execute if data storage advancement_race:history matches[{id:$(match_id),status:"ended"}] run function advancement_race:advancement_category_book/open
