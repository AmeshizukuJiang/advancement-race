data modify storage advancement_race:runtime participant_detail.name set from storage advancement_race:runtime participant_detail.participant.name
data modify storage advancement_race:runtime participant_detail.player_uuid set from storage advancement_race:runtime participant_detail.participant.uuid
data modify storage advancement_race:runtime participant_detail.points set from storage advancement_race:runtime participant_detail.participant.points
data modify storage advancement_race:runtime participant_detail.rank set from storage advancement_race:runtime participant_detail.participant.rank
data modify storage advancement_race:runtime participant_detail.completed set from storage advancement_race:runtime participant_detail.participant.completed
data modify storage advancement_race:runtime participant_detail.events set value []
data modify storage advancement_race:runtime participant_detail.rank_label set value "Current"
execute if data storage advancement_race:runtime participant_detail{source:{kind:"history"}} run data modify storage advancement_race:runtime participant_detail.rank_label set value "Final"
function advancement_race:info_center/participant_detail/copy_events with storage advancement_race:runtime participant_detail
execute store result score #participant_detail_points race_state run data get storage advancement_race:runtime participant_detail.points
execute if score #participant_detail_points race_state matches 0 run function advancement_race:info_center/participant_detail/show_header_no_score with storage advancement_race:runtime participant_detail
execute unless score #participant_detail_points race_state matches 0 run function advancement_race:info_center/participant_detail/show_header_ranked with storage advancement_race:runtime participant_detail
scoreboard players set #participant_detail_event_index race_state 0
data modify storage advancement_race:runtime participant_detail_work set value {event_index:0}
function advancement_race:info_center/participant_detail/show_events with storage advancement_race:runtime participant_detail_work
