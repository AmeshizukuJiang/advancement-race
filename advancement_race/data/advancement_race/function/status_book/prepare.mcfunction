data modify storage advancement_race:runtime status_book set value {status:"searching",events:[],pages:[]}
data modify storage advancement_race:runtime status_book_work set value {}
data modify storage advancement_race:runtime status_book.player_uuid set from entity @s UUID
data modify storage advancement_race:runtime status_book.match_id set from storage advancement_race:runtime status.match_id
data modify storage advancement_race:runtime status_book_work.player_uuid set from storage advancement_race:runtime status_book.player_uuid
scoreboard players set #status_book_participant_index race_state 0
data modify storage advancement_race:runtime status_book_work.participant_index set value 0
function advancement_race:status_book/find_participant with storage advancement_race:runtime status_book_work
execute unless data storage advancement_race:runtime status_book.participant run tellraw @s [{"text":"Cannot create status book: you are not a participant in the active match."}]
execute if data storage advancement_race:runtime status_book.participant run function advancement_race:status_book/copy_events
execute if data storage advancement_race:runtime status_book.participant run function advancement_race:status_book/build_pages
execute if data storage advancement_race:runtime status_book.participant run function advancement_race:status_book/give_item with storage advancement_race:runtime status_book
