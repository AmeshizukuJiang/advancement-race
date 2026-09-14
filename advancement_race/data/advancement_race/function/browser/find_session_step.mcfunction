$execute store result score #browser_session_candidate_token race_state run data get storage advancement_race:runtime browser.sessions[$(session_index)].token
$execute if score #browser_session_candidate_token race_state = #browser_clicked_token race_state run data modify storage advancement_race:runtime browser_work.session set from storage advancement_race:runtime browser.sessions[$(session_index)]
execute if score #browser_session_candidate_token race_state = #browser_clicked_token race_state run data modify storage advancement_race:runtime browser_work.session_found set value 1b
