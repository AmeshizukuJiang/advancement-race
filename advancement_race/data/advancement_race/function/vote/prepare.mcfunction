execute store result score #vote_current_match_id race_state run data get storage advancement_race:match id
execute unless data storage advancement_race:vote match_id run function advancement_race:vote/reset_for_match
execute if data storage advancement_race:vote match_id run execute store result score #vote_stored_match_id race_state run data get storage advancement_race:vote match_id
execute if data storage advancement_race:vote match_id unless score #vote_stored_match_id race_state = #vote_current_match_id race_state run function advancement_race:vote/reset_for_match
execute unless data storage advancement_race:vote voters run data modify storage advancement_race:vote voters set value []
