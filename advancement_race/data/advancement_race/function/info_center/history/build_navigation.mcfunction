scoreboard players set #info_history_nav_count race_state 0
execute if score #info_history_page race_state matches 1.. run function advancement_race:info_center/history/add_newer
execute if score #info_history_page race_state < #info_history_last_page race_state run function advancement_race:info_center/history/add_older
execute if score #info_history_nav_count race_state matches 0 run data modify storage advancement_race:runtime info_center.pages[0].raw.extra append value {text:"\n\nEnd of history",color:"#555555",bold:false}
