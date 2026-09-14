scoreboard players set #history_nav_count race_state 0
execute if score #history_page race_state matches 1.. run function advancement_race:history_book/add_newer_action
execute if score #history_page race_state < #history_last_page race_state run function advancement_race:history_book/add_older_action
execute if score #history_nav_count race_state matches 0 run data modify storage advancement_race:runtime browser_work.pages[0].raw.extra append value {text:"\n\nEnd of history",color:"#666666",bold:false}
