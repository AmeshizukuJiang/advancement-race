# Read-only administrator inspection. Temporary #admin_* scores are cleared before return.
execute store result score #admin_participant_count race_state run data get storage advancement_race:match participants
execute store result score #admin_event_count race_state run data get storage advancement_race:match events
scoreboard players set #admin_coop_event_count race_state 0
execute if data storage advancement_race:match cooperative.events store result score #admin_coop_event_count race_state run data get storage advancement_race:match cooperative.events
tellraw @s [{"text":"[Admin] Match\nID: "},{"storage":"advancement_race:match","nbt":"id"},{"text":"\nStatus: "},{"storage":"advancement_race:match","nbt":"status"},{"text":"\nMode: "},{"storage":"advancement_race:match","nbt":"mode"},{"text":"\nPrepared: "},{"storage":"advancement_race:match","nbt":"prepared"},{"text":"\nParticipants: "},{"score":{"name":"#admin_participant_count","objective":"race_state"}},{"text":"\nCompetitive events: "},{"score":{"name":"#admin_event_count","objective":"race_state"}},{"text":"\nCooperative events: "},{"score":{"name":"#admin_coop_event_count","objective":"race_state"}},{"text":"\n#match_active: "},{"score":{"name":"#match_active","objective":"race_state"}}]
scoreboard players reset #admin_participant_count race_state
scoreboard players reset #admin_event_count race_state
scoreboard players reset #admin_coop_event_count race_state
