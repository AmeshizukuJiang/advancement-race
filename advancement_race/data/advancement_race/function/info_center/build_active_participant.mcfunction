function advancement_race:status/calculate
execute store result score #info_center_participant_index race_state run scoreboard players get @s race_participant
execute store result storage advancement_race:runtime info_center_work.participant_index int 1 run scoreboard players get #info_center_participant_index race_state
execute if data storage advancement_race:runtime status{status:"ready"} run function advancement_race:info_center/copy_self_status with storage advancement_race:runtime info_center_work
function advancement_race:menu/prepare_vote_progress
execute store result storage advancement_race:runtime info_center.vote_count int 1 run scoreboard players get #menu_vote_count race_state
execute store result storage advancement_race:runtime info_center.required_votes int 1 run scoreboard players get #menu_required_votes race_state
scoreboard players set #info_center_participating race_state 1
data modify storage advancement_race:runtime info_center.pages set value [{raw:"Building Info Center"},{raw:"Building My Status"}]
function advancement_race:info_center/standings/build
execute store result score #info_center_page_count race_state run data get storage advancement_race:runtime info_center.pages
scoreboard players operation #info_center_index_array race_state = #info_center_page_count race_state
scoreboard players add #info_center_page_count race_state 1
execute store result storage advancement_race:runtime info_center.index_array_index int 1 run scoreboard players get #info_center_index_array race_state
execute store result storage advancement_race:runtime info_center.index_page int 1 run scoreboard players get #info_center_page_count race_state
data modify storage advancement_race:runtime info_center.pages append value {raw:"Building Advancement Index"}
function advancement_race:info_center/advancement_browser/build
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"vote_end_confirm"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.vote_action_code set from storage advancement_race:runtime browser_work.action_code
execute store result score #info_center_page_count race_state run data get storage advancement_race:runtime info_center.pages
scoreboard players add #info_center_page_count race_state 1
execute store result storage advancement_race:runtime info_center.vote_page int 1 run scoreboard players get #info_center_page_count race_state
function advancement_race:info_center/append_vote_page with storage advancement_race:runtime info_center
function advancement_race:info_center/build_active_participant_pages with storage advancement_race:runtime info_center
data modify storage advancement_race:runtime info_center.status set value "ready"
