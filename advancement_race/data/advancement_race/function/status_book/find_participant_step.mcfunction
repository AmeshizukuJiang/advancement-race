$data modify storage advancement_race:runtime status_book_work.candidate set from storage advancement_race:runtime status.participants[$(participant_index)]
scoreboard players set #status_book_uuid_match race_state 1
execute store result score #status_book_player_uuid_0 race_state run data get storage advancement_race:runtime status_book_work.player_uuid[0]
execute store result score #status_book_candidate_uuid_0 race_state run data get storage advancement_race:runtime status_book_work.candidate.uuid[0]
execute unless score #status_book_player_uuid_0 race_state = #status_book_candidate_uuid_0 race_state run scoreboard players set #status_book_uuid_match race_state 0
execute store result score #status_book_player_uuid_1 race_state run data get storage advancement_race:runtime status_book_work.player_uuid[1]
execute store result score #status_book_candidate_uuid_1 race_state run data get storage advancement_race:runtime status_book_work.candidate.uuid[1]
execute unless score #status_book_player_uuid_1 race_state = #status_book_candidate_uuid_1 race_state run scoreboard players set #status_book_uuid_match race_state 0
execute store result score #status_book_player_uuid_2 race_state run data get storage advancement_race:runtime status_book_work.player_uuid[2]
execute store result score #status_book_candidate_uuid_2 race_state run data get storage advancement_race:runtime status_book_work.candidate.uuid[2]
execute unless score #status_book_player_uuid_2 race_state = #status_book_candidate_uuid_2 race_state run scoreboard players set #status_book_uuid_match race_state 0
execute store result score #status_book_player_uuid_3 race_state run data get storage advancement_race:runtime status_book_work.player_uuid[3]
execute store result score #status_book_candidate_uuid_3 race_state run data get storage advancement_race:runtime status_book_work.candidate.uuid[3]
execute unless score #status_book_player_uuid_3 race_state = #status_book_candidate_uuid_3 race_state run scoreboard players set #status_book_uuid_match race_state 0
execute if score #status_book_uuid_match race_state matches 1 run data modify storage advancement_race:runtime status_book.participant set from storage advancement_race:runtime status_book_work.candidate
