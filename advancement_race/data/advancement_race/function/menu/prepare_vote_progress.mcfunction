scoreboard players set #menu_vote_count race_state 0
scoreboard players set #menu_vote_match_id race_state -1
scoreboard players set #menu_two race_state 2
execute store result score #menu_match_id race_state run data get storage advancement_race:match id
execute store result score #menu_roster_count race_state run data get storage advancement_race:match participants
scoreboard players operation #menu_required_votes race_state = #menu_roster_count race_state
scoreboard players operation #menu_required_votes race_state /= #menu_two race_state
scoreboard players add #menu_required_votes race_state 1
execute if data storage advancement_race:vote match_id run execute store result score #menu_vote_match_id race_state run data get storage advancement_race:vote match_id
execute if score #menu_vote_match_id race_state = #menu_match_id race_state if data storage advancement_race:vote voters run execute store result score #menu_vote_count race_state run data get storage advancement_race:vote voters
