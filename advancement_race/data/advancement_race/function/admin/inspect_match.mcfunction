# Read-only administrator inspection. Temporary #admin_* scores are cleared before return.
execute store result score #admin_participant_count race_state run data get storage advancement_race:match participants
execute store result score #admin_event_count race_state run data get storage advancement_race:match events
tellraw @s [{"text":"[Admin] Match\nID: "},{"storage":"advancement_race:match","nbt":"id"},{"text":"\nStatus: "},{"storage":"advancement_race:match","nbt":"status"},{"text":"\nPrepared: "},{"storage":"advancement_race:match","nbt":"prepared"},{"text":"\nParticipants: "},{"score":{"name":"#admin_participant_count","objective":"race_state"}},{"text":"\nEvents: "},{"score":{"name":"#admin_event_count","objective":"race_state"}},{"text":"\n#match_active: "},{"score":{"name":"#match_active","objective":"race_state"}}]
scoreboard players reset #admin_participant_count race_state
scoreboard players reset #admin_event_count race_state
