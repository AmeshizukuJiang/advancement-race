data modify storage advancement_race:match status set value "ended"
scoreboard players set #match_active race_state 0
data modify storage advancement_race:history matches append from storage advancement_race:match
tellraw @a [{"text":"Advancement Race match has ended."}]
