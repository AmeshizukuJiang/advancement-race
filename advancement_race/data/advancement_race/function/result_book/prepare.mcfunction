data modify storage advancement_race:runtime result_book set value {status:"searching",events:[],pages:[]}
data modify storage advancement_race:runtime result_book_work set value {}
data modify storage advancement_race:runtime result_book.player_uuid set from entity @s UUID
data modify storage advancement_race:runtime result_book.match_id set from storage advancement_race:runtime result.match_id
data modify storage advancement_race:runtime result_book_work.player_uuid set from storage advancement_race:runtime result_book.player_uuid
scoreboard players set #result_book_participant_index race_state 0
data modify storage advancement_race:runtime result_book_work.participant_index set value 0
function advancement_race:result_book/find_participant with storage advancement_race:runtime result_book_work
execute unless data storage advancement_race:runtime result_book.participant run tellraw @s [{"text":"You were not a participant in this match.","color":"red"}]
execute if data storage advancement_race:runtime result_book.participant run function advancement_race:result_book/copy_events
execute if data storage advancement_race:runtime result_book.participant run function advancement_race:result_book/build_pages
execute if data storage advancement_race:runtime result_book.participant run function advancement_race:result_book/give_item with storage advancement_race:runtime result_book
