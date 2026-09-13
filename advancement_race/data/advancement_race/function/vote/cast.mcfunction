scoreboard players set #vote_is_new race_state 1
$execute if data storage advancement_race:vote {voters:[$(participant_index)]} run scoreboard players set #vote_is_new race_state 0
execute if score #vote_is_new race_state matches 0 run tellraw @s [{"text":"You have already voted to end this match."}]
$execute if score #vote_is_new race_state matches 1 run data modify storage advancement_race:vote voters append value $(participant_index)
execute if score #vote_is_new race_state matches 1 run tellraw @s [{"text":"Your end vote was recorded."}]
execute if score #vote_is_new race_state matches 1 run execute store result score #vote_count race_state run data get storage advancement_race:vote voters
execute if score #vote_is_new race_state matches 1 run execute store result score #vote_participant_count race_state run data get storage advancement_race:match participants
execute if score #vote_is_new race_state matches 1 run scoreboard players operation #vote_doubled race_state = #vote_count race_state
execute if score #vote_is_new race_state matches 1 run scoreboard players set #vote_two race_state 2
execute if score #vote_is_new race_state matches 1 run scoreboard players operation #vote_doubled race_state *= #vote_two race_state
execute if score #vote_is_new race_state matches 1 if score #vote_doubled race_state > #vote_participant_count race_state run tellraw @a [{"text":"A majority voted to end the match."}]
execute if score #vote_is_new race_state matches 1 if score #vote_doubled race_state > #vote_participant_count race_state run function advancement_race:match/end
