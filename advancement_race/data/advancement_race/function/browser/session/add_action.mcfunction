execute store result score #browser_action_index race_state run data get storage advancement_race:runtime browser_work.session.actions
scoreboard players set #browser_action_stride race_state 256
execute store result score #browser_build_token race_state run data get storage advancement_race:runtime browser_work.session.token
scoreboard players operation #browser_action_code race_state = #browser_build_token race_state
scoreboard players operation #browser_action_code race_state *= #browser_action_stride race_state
scoreboard players add #browser_action_code race_state 1000
scoreboard players operation #browser_action_code race_state += #browser_action_index race_state
execute store result storage advancement_race:runtime browser_work.action_code int 1 run scoreboard players get #browser_action_code race_state
execute if score #browser_action_index race_state matches 0..255 run data modify storage advancement_race:runtime browser_work.session.actions append from storage advancement_race:runtime browser_work.pending_action
