execute store result score #next_match_id race_state run data get storage advancement_race:state next_match_id 1
scoreboard players add #next_match_id race_state 1
execute store result storage advancement_race:state next_match_id int 1 run scoreboard players get #next_match_id race_state
execute store result storage advancement_race:match id int 1 run scoreboard players get #next_match_id race_state
data modify storage advancement_race:match status set value "active"
data modify storage advancement_race:match prepared set value 0b
scoreboard players set #match_active race_state 1
tellraw @a [{"text":"Advancement Race match has started."}]
