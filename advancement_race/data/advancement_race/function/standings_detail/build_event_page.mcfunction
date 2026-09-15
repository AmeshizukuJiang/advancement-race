$data modify storage advancement_race:runtime standings_detail_work.sequence set from storage advancement_race:runtime standings_detail.events[$(page_index)].sequence
$data modify storage advancement_race:runtime standings_detail_work.advancement set from storage advancement_race:runtime standings_detail.events[$(page_index)].advancement
$data modify storage advancement_race:runtime standings_detail_work.place set from storage advancement_race:runtime standings_detail.events[$(page_index)].place
$data modify storage advancement_race:runtime standings_detail_work.points set from storage advancement_race:runtime standings_detail.events[$(page_index)].points
data modify storage advancement_race:runtime presentation set value {}
data modify storage advancement_race:runtime presentation.advancement set from storage advancement_race:runtime standings_detail_work.advancement
function advancement_race:presentation/resolve_advancement_title
data modify storage advancement_race:runtime standings_detail_work.title_translate set from storage advancement_race:runtime presentation.title_translate
execute if score #standings_detail_page_slot race_state matches 0 run function advancement_race:standings_detail/append_event_page with storage advancement_race:runtime standings_detail_work
execute if score #standings_detail_page_slot race_state matches 1 run function advancement_race:standings_detail/append_event_to_page with storage advancement_race:runtime standings_detail_work
scoreboard players add #standings_detail_page_slot race_state 1
execute if score #standings_detail_page_slot race_state matches 2 run scoreboard players set #standings_detail_page_slot race_state 0
