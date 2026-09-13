data modify storage advancement_race:runtime lobby_book set value {status:"building",pages:[]}
data modify storage advancement_race:runtime lobby_book_work set value {}
data modify storage advancement_race:runtime lobby_book.match_status set from storage advancement_race:match status
data modify storage advancement_race:runtime lobby_book.prepared set from storage advancement_race:match prepared
data modify storage advancement_race:runtime lobby_book.participants set from storage advancement_race:match participants
execute store result score #lobby_book_player_count race_state run data get storage advancement_race:runtime lobby_book.participants
execute store result storage advancement_race:runtime lobby_book.player_count int 1 run scoreboard players get #lobby_book_player_count race_state
data modify storage advancement_race:runtime lobby_book.player_uuid set from entity @s UUID
data modify storage advancement_race:runtime lobby_book_work.player_uuid set from storage advancement_race:runtime lobby_book.player_uuid
scoreboard players set #lobby_book_participant_index race_state 0
data modify storage advancement_race:runtime lobby_book_work.participant_index set value 0
function advancement_race:lobby_book/build_summary_unregistered with storage advancement_race:runtime lobby_book
execute if data storage advancement_race:runtime lobby_book.participants[0] run function advancement_race:lobby_book/find_player with storage advancement_race:runtime lobby_book_work
execute if data storage advancement_race:runtime lobby_book.registered run function advancement_race:lobby_book/build_summary_registered with storage advancement_race:runtime lobby_book
function advancement_race:lobby_book/build_roster_header with storage advancement_race:runtime lobby_book
scoreboard players set #lobby_book_roster_index race_state 0
data modify storage advancement_race:runtime lobby_book_work.roster_index set value 0
execute if data storage advancement_race:runtime lobby_book.participants[0] run function advancement_race:lobby_book/build_roster_entries with storage advancement_race:runtime lobby_book_work
data modify storage advancement_race:runtime lobby_book.status set value "ready"
function advancement_race:lobby_book/give_item with storage advancement_race:runtime lobby_book
