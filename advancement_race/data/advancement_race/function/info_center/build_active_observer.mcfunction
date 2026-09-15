scoreboard players set #info_center_participating race_state 0
function advancement_race:status/calculate
data modify storage advancement_race:runtime info_center.pages set value [{raw:"Building Info Center"}]
function advancement_race:info_center/standings/build
execute store result score #info_center_page_count race_state run data get storage advancement_race:runtime info_center.pages
scoreboard players operation #info_center_index_array race_state = #info_center_page_count race_state
scoreboard players add #info_center_page_count race_state 1
execute store result storage advancement_race:runtime info_center.index_array_index int 1 run scoreboard players get #info_center_index_array race_state
execute store result storage advancement_race:runtime info_center.index_page int 1 run scoreboard players get #info_center_page_count race_state
data modify storage advancement_race:runtime info_center.pages append value {raw:"Building Advancement Index"}
function advancement_race:info_center/advancement_browser/build
function advancement_race:info_center/build_active_observer_pages with storage advancement_race:runtime info_center
data modify storage advancement_race:runtime info_center.status set value "ready"
