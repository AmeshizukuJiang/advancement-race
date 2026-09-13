scoreboard players reset * race_participant
scoreboard players reset * race_points
scoreboard players reset * race_place
scoreboard players reset * race_award
function advancement_race:match/reset_counters
scoreboard players set #match_active race_state 0
scoreboard players set #event_index race_state 0
scoreboard players set #event_sequence race_state 0
data modify storage advancement_race:match id set value 0
data modify storage advancement_race:match status set value "idle"
data modify storage advancement_race:match prepared set value 1b
data modify storage advancement_race:match participants set value []
data modify storage advancement_race:match events set value []
tellraw @s [{"text":"Advancement Race match reset. Register participants before starting."}]
