execute store result score #coop_event_index race_state run data get storage advancement_race:match cooperative.events
scoreboard players operation #coop_event_sequence race_state = #coop_event_index race_state
scoreboard players add #coop_event_sequence race_state 1
data modify storage advancement_race:runtime cooperative_event set from storage advancement_race:runtime cooperative_completion
data remove storage advancement_race:runtime cooperative_event.title
data remove storage advancement_race:runtime cooperative_event.title_translate
execute store result storage advancement_race:runtime cooperative_event.sequence int 1 run scoreboard players get #coop_event_sequence race_state
data modify storage advancement_race:runtime cooperative_event.player_uuid set from entity @s UUID
execute store result storage advancement_race:runtime cooperative_event.participant_index int 1 run scoreboard players get @s race_participant
function advancement_race:cooperative/events/capture_name with storage advancement_race:runtime cooperative_event
data modify storage advancement_race:match cooperative.events append from storage advancement_race:runtime cooperative_event
data modify storage advancement_race:match cooperative.last_event set from storage advancement_race:runtime cooperative_event
