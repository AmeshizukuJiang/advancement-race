scoreboard players set #browser_context_valid race_state 1
execute unless data storage advancement_race:runtime browser_work.session.context.match_id run scoreboard players set #browser_context_valid race_state 0
execute unless data storage advancement_race:runtime browser_work.session.context.status run scoreboard players set #browser_context_valid race_state 0
execute unless data storage advancement_race:runtime browser_work.session.context.prepared run scoreboard players set #browser_context_valid race_state 0
scoreboard players set #browser_context_match_id race_state 0
scoreboard players set #browser_current_match_id race_state 0
execute store result score #browser_context_match_id race_state run data get storage advancement_race:runtime browser_work.session.context.match_id
execute store result score #browser_current_match_id race_state run data get storage advancement_race:match id
execute unless score #browser_context_match_id race_state = #browser_current_match_id race_state run scoreboard players set #browser_context_valid race_state 0
scoreboard players set #browser_context_status_match race_state 0
execute if data storage advancement_race:runtime browser_work.session{context:{status:"idle"}} if data storage advancement_race:match {status:"idle"} run scoreboard players set #browser_context_status_match race_state 1
execute if data storage advancement_race:runtime browser_work.session{context:{status:"active"}} if data storage advancement_race:match {status:"active"} run scoreboard players set #browser_context_status_match race_state 1
execute if data storage advancement_race:runtime browser_work.session{context:{status:"ended"}} if data storage advancement_race:match {status:"ended"} run scoreboard players set #browser_context_status_match race_state 1
execute unless score #browser_context_status_match race_state matches 1 run scoreboard players set #browser_context_valid race_state 0
scoreboard players set #browser_context_prepared_match race_state 0
execute if data storage advancement_race:runtime browser_work.session{context:{prepared:0b}} if data storage advancement_race:match {prepared:0b} run scoreboard players set #browser_context_prepared_match race_state 1
execute if data storage advancement_race:runtime browser_work.session{context:{prepared:1b}} if data storage advancement_race:match {prepared:1b} run scoreboard players set #browser_context_prepared_match race_state 1
execute unless score #browser_context_prepared_match race_state matches 1 run scoreboard players set #browser_context_valid race_state 0
execute unless score #browser_context_valid race_state matches 1 run scoreboard players set #browser_valid race_state 0
