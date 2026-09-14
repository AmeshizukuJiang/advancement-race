$execute store result score #browser_remove_candidate race_state run data get storage advancement_race:runtime browser.sessions[$(session_index)].token
$execute if score #browser_remove_candidate race_state = #browser_remove_token race_state run data remove storage advancement_race:runtime browser.sessions[$(session_index)]
execute if score #browser_remove_candidate race_state = #browser_remove_token race_state run scoreboard players set #browser_remove_done race_state 1
