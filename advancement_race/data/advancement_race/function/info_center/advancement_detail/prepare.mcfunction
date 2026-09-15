$data modify storage advancement_race:runtime advancement_detail set value {advancement:"$(advancement)",title_translate:"$(title_translate)",base_score:$(base_score),events:[]}
data modify storage advancement_race:runtime advancement_detail.source set from storage advancement_race:runtime browser_work.session.source
$execute if data storage advancement_race:runtime advancement_detail{source:{kind:"current"}} run data modify storage advancement_race:runtime advancement_detail.events append from storage advancement_race:match events[{advancement:"$(advancement)"}]
$execute if data storage advancement_race:runtime advancement_detail{source:{kind:"history"}} run data modify storage advancement_race:runtime advancement_detail.events append from storage advancement_race:runtime result.events[{advancement:"$(advancement)"}]
execute store result score #advancement_detail_completed race_state run data get storage advancement_race:runtime advancement_detail.events
execute if data storage advancement_race:runtime advancement_detail{source:{kind:"current"}} store result score #advancement_detail_roster race_state run data get storage advancement_race:match participants
execute if data storage advancement_race:runtime advancement_detail{source:{kind:"history"}} store result score #advancement_detail_roster race_state run data get storage advancement_race:runtime result.participants
scoreboard players operation #advancement_detail_not_completed race_state = #advancement_detail_roster race_state
scoreboard players operation #advancement_detail_not_completed race_state -= #advancement_detail_completed race_state
execute if score #advancement_detail_not_completed race_state matches ..-1 run scoreboard players set #advancement_detail_not_completed race_state 0
execute store result storage advancement_race:runtime advancement_detail.completed_count int 1 run scoreboard players get #advancement_detail_completed race_state
execute store result storage advancement_race:runtime advancement_detail.roster_count int 1 run scoreboard players get #advancement_detail_roster race_state
execute store result storage advancement_race:runtime advancement_detail.not_completed_count int 1 run scoreboard players get #advancement_detail_not_completed race_state
function advancement_race:info_center/advancement_detail/show_header with storage advancement_race:runtime advancement_detail
scoreboard players set #advancement_detail_event_index race_state 0
data modify storage advancement_race:runtime advancement_detail_work set value {event_index:0}
function advancement_race:info_center/advancement_detail/show_events with storage advancement_race:runtime advancement_detail_work
function advancement_race:info_center/advancement_detail/show_footer with storage advancement_race:runtime advancement_detail
