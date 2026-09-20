data modify storage advancement_race:runtime info_center set value {status:"building",source:{kind:"history",mode:"cooperative_border"},pages:[]}
data modify storage advancement_race:runtime info_center.match_id set from storage advancement_race:runtime coop_history.id
data modify storage advancement_race:runtime info_center.team_points set from storage advancement_race:runtime coop_history.cooperative.team_points
data modify storage advancement_race:runtime info_center.border_size set from storage advancement_race:runtime coop_history.cooperative.border.size
data modify storage advancement_race:runtime info_center.vanilla_completed set from storage advancement_race:runtime coop_history.cooperative.vanilla_completed
data modify storage advancement_race:runtime info_center.challenge_completed set from storage advancement_race:runtime coop_history.cooperative.challenge_completed
data modify storage advancement_race:runtime info_center.supply_status set from storage advancement_race:runtime coop_history.cooperative.challenges.supply.status
data modify storage advancement_race:runtime info_center.relay_status set from storage advancement_race:runtime coop_history.cooperative.challenges.relay.status
data modify storage advancement_race:runtime info_center.relay_attempts set from storage advancement_race:runtime coop_history.cooperative.challenges.relay.attempts
data modify storage advancement_race:runtime info_center.end_reason set value "unknown"
execute if data storage advancement_race:runtime coop_history.end_reason run data modify storage advancement_race:runtime info_center.end_reason set from storage advancement_race:runtime coop_history.end_reason
execute store result score #coop_history_participants race_state run data get storage advancement_race:runtime coop_history.participants
execute store result score #coop_history_events race_state run data get storage advancement_race:runtime coop_history.cooperative.events
execute store result storage advancement_race:runtime info_center.participant_count int 1 run scoreboard players get #coop_history_participants race_state
execute store result storage advancement_race:runtime info_center.event_count int 1 run scoreboard players get #coop_history_events race_state
execute store result score #coop_ui_duration race_state run data get storage advancement_race:runtime coop_history.cooperative.duration_ticks
scoreboard players set #coop_ui_twenty race_state 20
scoreboard players operation #coop_ui_duration race_state /= #coop_ui_twenty race_state
scoreboard players set #coop_ui_sixty race_state 60
scoreboard players operation #coop_ui_minutes race_state = #coop_ui_duration race_state
scoreboard players operation #coop_ui_minutes race_state /= #coop_ui_sixty race_state
scoreboard players operation #coop_ui_seconds race_state = #coop_ui_duration race_state
scoreboard players operation #coop_ui_seconds race_state %= #coop_ui_sixty race_state
execute store result storage advancement_race:runtime info_center.duration_minutes int 1 run scoreboard players get #coop_ui_minutes race_state
execute store result storage advancement_race:runtime info_center.duration_seconds int 1 run scoreboard players get #coop_ui_seconds race_state
data modify storage advancement_race:runtime browser_request set value {view:"info_center",source:{kind:"history",mode:"cooperative_border"}}
data modify storage advancement_race:runtime browser_request.source.match_id set from storage advancement_race:runtime coop_history.id
function advancement_race:browser/session/begin
function advancement_race:cooperative/ui/history/build_pages with storage advancement_race:runtime info_center
data modify storage advancement_race:runtime coop_history_work set value {participant_index:0}
scoreboard players set #coop_history_participant_index race_state 0
function advancement_race:cooperative/ui/history/append_roster with storage advancement_race:runtime coop_history_work
data modify storage advancement_race:runtime info_center.status set value "ready"
function advancement_race:browser/session/finalize
function advancement_race:info_center/deliver
