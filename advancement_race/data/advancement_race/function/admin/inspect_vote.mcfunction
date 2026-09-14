# Read-only administrator inspection. Temporary #admin_* scores are cleared before return.
execute store result score #admin_roster_count race_state run data get storage advancement_race:match participants
execute store result score #admin_current_match_id race_state run data get storage advancement_race:match id
scoreboard players set #admin_vote_present race_state 0
scoreboard players set #admin_vote_match_id race_state -1
scoreboard players set #admin_voter_count race_state 0
scoreboard players set #admin_effective_voter_count race_state 0
execute if data storage advancement_race:vote match_id run scoreboard players set #admin_vote_present race_state 1
execute if data storage advancement_race:vote match_id run execute store result score #admin_vote_match_id race_state run data get storage advancement_race:vote match_id
execute if data storage advancement_race:vote voters run execute store result score #admin_voter_count race_state run data get storage advancement_race:vote voters
execute if score #admin_vote_present race_state matches 1 if score #admin_vote_match_id race_state = #admin_current_match_id race_state run scoreboard players operation #admin_effective_voter_count race_state = #admin_voter_count race_state
tellraw @s [{"text":"[Admin] End Vote\nCurrent match ID: "},{"score":{"name":"#admin_current_match_id","objective":"race_state"}},{"text":"\nCurrent roster: "},{"score":{"name":"#admin_roster_count","objective":"race_state"}}]
execute unless score #admin_vote_present race_state matches 1 run tellraw @s [{"text":"Vote match ID: none\nEffective voters: 0\nCurrent active match: no vote cache"}]
execute if score #admin_vote_present race_state matches 1 if score #admin_vote_match_id race_state = #admin_current_match_id race_state run tellraw @s [{"text":"Vote match ID: "},{"score":{"name":"#admin_vote_match_id","objective":"race_state"}},{"text":"\nVoters: "},{"score":{"name":"#admin_effective_voter_count","objective":"race_state"}}]
execute if score #admin_vote_present race_state matches 1 unless score #admin_vote_match_id race_state = #admin_current_match_id race_state run tellraw @s [{"text":"Vote match ID: "},{"score":{"name":"#admin_vote_match_id","objective":"race_state"}},{"text":"\nWARN stale vote data belongs to a different match\nEffective voters: 0"}]
execute if score #admin_vote_present race_state matches 1 if data storage advancement_race:match {status:"active"} if score #admin_vote_match_id race_state = #admin_current_match_id race_state run tellraw @s [{"text":"Current active match: yes"}]
execute if score #admin_vote_present race_state matches 1 if data storage advancement_race:match {status:"active"} unless score #admin_vote_match_id race_state = #admin_current_match_id race_state run tellraw @s [{"text":"Current active match: yes\nVote cache: stale (match ID mismatch)"}]
execute if score #admin_vote_present race_state matches 1 unless data storage advancement_race:match {status:"active"} run tellraw @s [{"text":"Current active match: no (match is not active)"}]
scoreboard players reset #admin_roster_count race_state
scoreboard players reset #admin_current_match_id race_state
scoreboard players reset #admin_vote_present race_state
scoreboard players reset #admin_vote_match_id race_state
scoreboard players reset #admin_voter_count race_state
scoreboard players reset #admin_effective_voter_count race_state
