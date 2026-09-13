execute store result score #event_index race_state run data get storage advancement_race:match events
scoreboard players operation #event_sequence race_state = #event_index race_state
scoreboard players add #event_sequence race_state 1
execute store result storage advancement_race:runtime event_index int 1 run scoreboard players get #event_index race_state
execute store result storage advancement_race:runtime sequence int 1 run scoreboard players get #event_sequence race_state
execute store result storage advancement_race:runtime place int 1 run scoreboard players get @s race_place
execute store result storage advancement_race:runtime points int 1 run scoreboard players get @s race_award
data modify storage advancement_race:runtime player_uuid set from entity @s UUID
data modify storage advancement_race:runtime player_name set value "UNREGISTERED"
execute if score @s race_participant matches 0.. store result storage advancement_race:runtime participant_index int 1 run scoreboard players get @s race_participant
execute if score @s race_participant matches 0.. run function advancement_race:events/capture_name with storage advancement_race:runtime
data modify storage advancement_race:match events append value {}
function advancement_race:events/write_event with storage advancement_race:runtime
