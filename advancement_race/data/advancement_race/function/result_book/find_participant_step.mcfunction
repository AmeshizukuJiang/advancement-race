$data modify storage advancement_race:runtime result_book_work.candidate set from storage advancement_race:runtime result.participants[$(participant_index)]
scoreboard players set #result_book_uuid_match race_state 1
execute store result score #result_book_player_uuid_0 race_state run data get storage advancement_race:runtime result_book_work.player_uuid[0]
execute store result score #result_book_candidate_uuid_0 race_state run data get storage advancement_race:runtime result_book_work.candidate.uuid[0]
execute unless score #result_book_player_uuid_0 race_state = #result_book_candidate_uuid_0 race_state run scoreboard players set #result_book_uuid_match race_state 0
execute store result score #result_book_player_uuid_1 race_state run data get storage advancement_race:runtime result_book_work.player_uuid[1]
execute store result score #result_book_candidate_uuid_1 race_state run data get storage advancement_race:runtime result_book_work.candidate.uuid[1]
execute unless score #result_book_player_uuid_1 race_state = #result_book_candidate_uuid_1 race_state run scoreboard players set #result_book_uuid_match race_state 0
execute store result score #result_book_player_uuid_2 race_state run data get storage advancement_race:runtime result_book_work.player_uuid[2]
execute store result score #result_book_candidate_uuid_2 race_state run data get storage advancement_race:runtime result_book_work.candidate.uuid[2]
execute unless score #result_book_player_uuid_2 race_state = #result_book_candidate_uuid_2 race_state run scoreboard players set #result_book_uuid_match race_state 0
execute store result score #result_book_player_uuid_3 race_state run data get storage advancement_race:runtime result_book_work.player_uuid[3]
execute store result score #result_book_candidate_uuid_3 race_state run data get storage advancement_race:runtime result_book_work.candidate.uuid[3]
execute unless score #result_book_player_uuid_3 race_state = #result_book_candidate_uuid_3 race_state run scoreboard players set #result_book_uuid_match race_state 0
execute if score #result_book_uuid_match race_state matches 1 run data modify storage advancement_race:runtime result_book.participant set from storage advancement_race:runtime result_book_work.candidate
