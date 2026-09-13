execute store result score #participant_index race_state run data get storage advancement_race:match participants
scoreboard players operation @s race_participant = #participant_index race_state
scoreboard players set @s race_points 0
scoreboard players set @s race_place 0
scoreboard players set @s race_award 0
advancement revoke @s only advancement_race:stone_age_reward
advancement revoke @s only advancement_race:a_seedy_place_reward
advancement revoke @s only advancement_race:monster_hunter_reward
data modify storage advancement_race:match participants append value {}
execute store result storage advancement_race:runtime participant_index int 1 run scoreboard players get @s race_participant
data modify storage advancement_race:runtime player_uuid set from entity @s UUID
$data modify storage advancement_race:runtime player_name set value "$(name)"
function advancement_race:match/save_participant with storage advancement_race:runtime
