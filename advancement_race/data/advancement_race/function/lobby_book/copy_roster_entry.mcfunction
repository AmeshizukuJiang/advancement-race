$data modify storage advancement_race:runtime lobby_book_work.roster_entry set from storage advancement_race:runtime lobby_book.participants[$(roster_index)]
data modify storage advancement_race:runtime lobby_book_work.roster_player_name set from storage advancement_race:runtime lobby_book_work.roster_entry.name
scoreboard players operation #lobby_book_list_number race_state = #lobby_book_roster_index race_state
scoreboard players add #lobby_book_list_number race_state 1
execute store result storage advancement_race:runtime lobby_book_work.list_number int 1 run scoreboard players get #lobby_book_list_number race_state
function advancement_race:lobby_book/append_roster_entry with storage advancement_race:runtime lobby_book_work
