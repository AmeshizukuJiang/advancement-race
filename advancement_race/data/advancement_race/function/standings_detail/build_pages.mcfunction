execute store result score #standings_detail_points race_state run data get storage advancement_race:runtime standings_detail.points
execute if data storage advancement_race:runtime standings_detail{mode:"live"} if score #standings_detail_points race_state matches 0 run function advancement_race:standings_detail/build_live_summary_no_score with storage advancement_race:runtime standings_detail
execute if data storage advancement_race:runtime standings_detail{mode:"live"} unless score #standings_detail_points race_state matches 0 run function advancement_race:standings_detail/build_live_summary_rank with storage advancement_race:runtime standings_detail
execute if data storage advancement_race:runtime standings_detail{mode:"final"} run function advancement_race:standings_detail/build_final_summary with storage advancement_race:runtime standings_detail
scoreboard players set #standings_detail_page_index race_state 0
scoreboard players set #standings_detail_page_slot race_state 0
data modify storage advancement_race:runtime standings_detail_work.page_index set value 0
function advancement_race:standings_detail/build_event_pages with storage advancement_race:runtime standings_detail_work
data modify storage advancement_race:runtime standings_detail.status set value "ready"
