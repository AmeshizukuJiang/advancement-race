execute unless data storage advancement_race:state initialized run scoreboard objectives add race_points dummy "Advancement Race Points"
data modify storage advancement_race:state initialized set value 1b
execute unless data storage advancement_race:state order_objectives run scoreboard objectives add race_state dummy "Race State"
execute unless data storage advancement_race:state order_objectives run scoreboard objectives add race_place dummy "Race Place"
execute unless data storage advancement_race:state order_objectives run scoreboard objectives add race_award dummy "Race Award"
data modify storage advancement_race:state order_objectives set value 1b
scoreboard players add #stone_age_count race_state 0
scoreboard players add #a_seedy_place_count race_state 0
scoreboard players add #monster_hunter_count race_state 0
scoreboard players set #score_percent race_state 100
scoreboard players set #match_active race_state 0
execute unless data storage advancement_race:state event_objectives run scoreboard objectives add race_participant dummy "Race Participant"
data modify storage advancement_race:state event_objectives set value 1b
execute unless data storage advancement_race:match participants run data modify storage advancement_race:match participants set value []
execute unless data storage advancement_race:match events run data modify storage advancement_race:match events set value []
execute unless data storage advancement_race:match status run data modify storage advancement_race:match status set value "idle"
execute unless data storage advancement_race:match id run data modify storage advancement_race:match id set value 0
execute unless data storage advancement_race:match prepared run data modify storage advancement_race:match prepared set value 0b
execute unless data storage advancement_race:history matches run data modify storage advancement_race:history matches set value []
execute unless data storage advancement_race:state next_match_id run data modify storage advancement_race:state next_match_id set value 0
execute if data storage advancement_race:match {status:"active"} run scoreboard players set #match_active race_state 1
