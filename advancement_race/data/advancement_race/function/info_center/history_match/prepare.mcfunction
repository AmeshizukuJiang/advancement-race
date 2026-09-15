data modify storage advancement_race:runtime info_center set value {status:"building",source:{kind:"history"},pages:[{raw:"Building Info Center"},{raw:"Building My Result"}],registered:0b}
data modify storage advancement_race:runtime info_center.match_id set from storage advancement_race:runtime result.match_id
data modify storage advancement_race:runtime info_center.participants set from storage advancement_race:runtime result.participants
data modify storage advancement_race:runtime info_center.player_uuid set from entity @s UUID
execute store result score #info_center_player_count race_state run data get storage advancement_race:runtime result.participants
execute store result storage advancement_race:runtime info_center.player_count int 1 run scoreboard players get #info_center_player_count race_state
scoreboard players set #info_center_participating race_state 0
scoreboard players set #info_center_history_self_index race_state 0
data modify storage advancement_race:runtime info_center_history_work set value {participant_index:0}
data modify storage advancement_race:runtime info_center_history_work.player_uuid set from entity @s UUID
function advancement_race:info_center/history_match/find_self with storage advancement_race:runtime info_center_history_work
data modify storage advancement_race:runtime browser_request set value {view:"info_center",source:{kind:"history"}}
data modify storage advancement_race:runtime browser_request.source.match_id set from storage advancement_race:runtime result.match_id
function advancement_race:browser/session/begin
function advancement_race:info_center/standings/build
execute store result score #info_center_page_count race_state run data get storage advancement_race:runtime info_center.pages
scoreboard players operation #info_center_index_array race_state = #info_center_page_count race_state
scoreboard players add #info_center_page_count race_state 1
execute store result storage advancement_race:runtime info_center.index_array_index int 1 run scoreboard players get #info_center_index_array race_state
execute store result storage advancement_race:runtime info_center.index_page int 1 run scoreboard players get #info_center_page_count race_state
data modify storage advancement_race:runtime info_center.pages append value {raw:"Building Advancement Index"}
function advancement_race:info_center/advancement_browser/build
execute if score #info_center_participating race_state matches 1 run function advancement_race:info_center/history_match/build_participant_pages with storage advancement_race:runtime info_center
execute unless score #info_center_participating race_state matches 1 run function advancement_race:info_center/history_match/build_observer_pages with storage advancement_race:runtime info_center
data modify storage advancement_race:runtime info_center.status set value "ready"
function advancement_race:browser/session/finalize
function advancement_race:info_center/deliver
