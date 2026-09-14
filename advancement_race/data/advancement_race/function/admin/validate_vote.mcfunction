execute store result score #admin_current_match_id race_state run data get storage advancement_race:match id
scoreboard players set #admin_vote_present race_state 0
scoreboard players set #admin_vote_match_id race_state -1
scoreboard players set #admin_voter_count race_state 0
execute if data storage advancement_race:vote match_id run scoreboard players set #admin_vote_present race_state 1
execute if data storage advancement_race:vote match_id run execute store result score #admin_vote_match_id race_state run data get storage advancement_race:vote match_id
execute if data storage advancement_race:vote voters run execute store result score #admin_voter_count race_state run data get storage advancement_race:vote voters
execute if data storage advancement_race:match {status:"active"} unless score #admin_vote_present race_state matches 1 run tellraw @s [{"text":"WARN active match has no initialized vote cache"}]
execute if data storage advancement_race:match {status:"active"} if score #admin_vote_present race_state matches 1 if score #admin_vote_match_id race_state = #admin_current_match_id race_state run tellraw @s [{"text":"PASS vote match ID matches the active match"}]
execute if data storage advancement_race:match {status:"active"} if score #admin_vote_present race_state matches 1 unless score #admin_vote_match_id race_state = #admin_current_match_id race_state run tellraw @s [{"text":"FAIL vote match ID does not match the active match"}]
execute unless data storage advancement_race:match {status:"active"} run tellraw @s [{"text":"WARN vote match ID is not required outside an active match"}]
execute if score #admin_voter_count race_state > #admin_roster_count race_state run tellraw @s [{"text":"FAIL voter count exceeds roster size; vote indices are invalid"}]
execute unless score #admin_voter_count race_state > #admin_roster_count race_state run tellraw @s [{"text":"PASS voter count does not exceed roster size"}]
execute unless score #admin_invalid_participants race_state matches 0 run tellraw @s [{"text":"WARN an online race_participant index is invalid; normal vote sources may be affected"}]
tellraw @s [{"text":"WARN strict read-only validation cannot enumerate individual stored voter indices"}]
