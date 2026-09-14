scoreboard players set #vote_is_new race_state 1
$execute if data storage advancement_race:vote {voters:[$(participant_index)]} run scoreboard players set #vote_is_new race_state 0
$execute if score #vote_is_new race_state matches 1 run data modify storage advancement_race:vote voters append value $(participant_index)
execute store result score #vote_count race_state run data get storage advancement_race:vote voters
execute store result score #vote_participant_count race_state run data get storage advancement_race:match participants
scoreboard players set #vote_two race_state 2
scoreboard players operation #vote_required race_state = #vote_participant_count race_state
scoreboard players operation #vote_required race_state /= #vote_two race_state
scoreboard players add #vote_required race_state 1
execute if score #vote_is_new race_state matches 0 run tellraw @s [{"text":"You already voted. ","color":"yellow"},{"text":"End Vote: ","color":"gray"},{"score":{"name":"#vote_count","objective":"race_state"},"color":"yellow"},{"text":" / ","color":"gray"},{"score":{"name":"#vote_required","objective":"race_state"},"color":"yellow"},{"text":" Required","color":"gray"}]
execute if score #vote_is_new race_state matches 1 run tellraw @s [{"text":"Vote recorded. ","color":"green"},{"text":"End Vote: ","color":"gray"},{"score":{"name":"#vote_count","objective":"race_state"},"color":"yellow"},{"text":" / ","color":"gray"},{"score":{"name":"#vote_required","objective":"race_state"},"color":"yellow"},{"text":" Required","color":"gray"}]
execute if score #vote_is_new race_state matches 1 run scoreboard players operation #vote_doubled race_state = #vote_count race_state
execute if score #vote_is_new race_state matches 1 run scoreboard players operation #vote_doubled race_state *= #vote_two race_state
execute if score #vote_is_new race_state matches 1 if score #vote_doubled race_state > #vote_participant_count race_state run tellraw @a [{"text":"End Vote passed: ","color":"gold","bold":true},{"score":{"name":"#vote_count","objective":"race_state"},"color":"yellow","bold":false},{"text":" / ","color":"gray"},{"score":{"name":"#vote_required","objective":"race_state"},"color":"yellow"},{"text":" Required","color":"gray"}]
execute if score #vote_is_new race_state matches 1 if score #vote_doubled race_state > #vote_participant_count race_state run function advancement_race:match/end
