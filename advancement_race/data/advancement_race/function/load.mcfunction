execute unless data storage advancement_race:state initialized run scoreboard objectives add race_points dummy "Advancement Race Points"
data modify storage advancement_race:state initialized set value 1b
execute unless data storage advancement_race:state order_objectives run scoreboard objectives add race_state dummy "Race State"
execute unless data storage advancement_race:state order_objectives run scoreboard objectives add race_place dummy "Race Place"
execute unless data storage advancement_race:state order_objectives run scoreboard objectives add race_award dummy "Race Award"
data modify storage advancement_race:state order_objectives set value 1b
function advancement_race:scoring/initialize_counters
scoreboard players set #score_percent race_state 100
scoreboard players set #match_active race_state 0
execute unless data storage advancement_race:state event_objectives run scoreboard objectives add race_participant dummy "Race Participant"
data modify storage advancement_race:state event_objectives set value 1b
execute unless data storage advancement_race:state cooperative_modifier_objectives run scoreboard objectives add race_deaths deathCount
execute unless data storage advancement_race:state cooperative_modifier_objectives run scoreboard objectives add race_death_seen dummy "Race Death Baseline"
data modify storage advancement_race:state cooperative_modifier_objectives set value 1b
execute unless data storage advancement_race:state cooperative_challenge_objectives run scoreboard objectives add race_challenge_death_seen dummy "Challenge Death Baseline"
data modify storage advancement_race:state cooperative_challenge_objectives set value 1b
execute unless data storage advancement_race:state cooperative_n6_objectives run scoreboard objectives add race_cold_strider dummy "Cold Strider Duration"
data modify storage advancement_race:state cooperative_n6_objectives set value 1b
execute unless data storage advancement_race:match participants run data modify storage advancement_race:match participants set value []
execute unless data storage advancement_race:match events run data modify storage advancement_race:match events set value []
execute unless data storage advancement_race:match status run data modify storage advancement_race:match status set value "idle"
execute unless data storage advancement_race:match id run data modify storage advancement_race:match id set value 0
execute unless data storage advancement_race:match prepared run data modify storage advancement_race:match prepared set value 0b
execute if data storage advancement_race:match {status:"idle",prepared:1b} unless data storage advancement_race:match mode run data modify storage advancement_race:match mode set value "competitive"
execute unless data storage advancement_race:history matches run data modify storage advancement_race:history matches set value []
execute unless data storage advancement_race:state next_match_id run data modify storage advancement_race:state next_match_id set value 0
execute if data storage advancement_race:match {status:"active"} run scoreboard players set #match_active race_state 1
scoreboard objectives add race_menu trigger "Race Menu"
scoreboard objectives add race_browser dummy "Race Browser"
scoreboard players set @a race_menu 0
scoreboard players enable @a race_menu
scoreboard players reset @a race_browser
data remove storage advancement_race:runtime browser
function advancement_race:cooperative/load
