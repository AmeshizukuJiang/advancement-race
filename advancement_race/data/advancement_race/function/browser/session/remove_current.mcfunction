scoreboard players operation #browser_remove_token race_state = @s race_browser
scoreboard players set #browser_remove_index race_state 0
scoreboard players set #browser_remove_done race_state 0
data modify storage advancement_race:runtime browser_remove_work set value {session_index:0}
function advancement_race:browser/session/remove_current_loop with storage advancement_race:runtime browser_remove_work
data remove storage advancement_race:runtime browser_remove_work
