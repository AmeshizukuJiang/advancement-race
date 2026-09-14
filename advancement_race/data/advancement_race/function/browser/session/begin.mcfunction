execute unless data storage advancement_race:runtime browser.sessions run data modify storage advancement_race:runtime browser.sessions set value []
execute if score @s race_browser matches -2147483648..2147483647 run function advancement_race:browser/session/remove_current
scoreboard players add #browser_next_token race_state 1
execute if score #browser_next_token race_state matches 8000000.. run function advancement_race:browser/session/wrap_tokens
scoreboard players operation @s race_browser = #browser_next_token race_state
data modify storage advancement_race:runtime browser_work set value {pages:[],session:{actions:[]}}
data modify storage advancement_race:runtime browser_work.session set from storage advancement_race:runtime browser_request
data modify storage advancement_race:runtime browser_work.session.actions set value []
execute store result storage advancement_race:runtime browser_work.session.token int 1 run scoreboard players get @s race_browser
data modify storage advancement_race:runtime browser_work.session.owner_uuid set from entity @s UUID
data modify storage advancement_race:runtime browser_work.session.context set value {}
data modify storage advancement_race:runtime browser_work.session.context.match_id set from storage advancement_race:match id
data modify storage advancement_race:runtime browser_work.session.context.status set from storage advancement_race:match status
data modify storage advancement_race:runtime browser_work.session.context.prepared set from storage advancement_race:match prepared
