execute store result score #admin_roster_count race_state run data get storage advancement_race:match participants
execute if data storage advancement_race:match {status:"active"} if data storage advancement_race:match participants[0] run tellraw @s [{"text":"PASS active match has at least one participant"}]
execute if data storage advancement_race:match {status:"active"} unless data storage advancement_race:match participants[0] run tellraw @s [{"text":"FAIL active match has no participants"}]
execute unless data storage advancement_race:match {status:"active"} run tellraw @s [{"text":"WARN participant presence is only required while active"}]
scoreboard players set #admin_invalid_participants race_state 0
scoreboard players set #admin_online_participants race_state 0
execute as @a if score @s race_participant matches 0.. unless score @s race_participant < #admin_roster_count race_state run scoreboard players add #admin_invalid_participants race_state 1
execute as @a if score @s race_participant matches 0.. if score @s race_participant < #admin_roster_count race_state run scoreboard players add #admin_online_participants race_state 1
execute if score #admin_invalid_participants race_state matches 0 run tellraw @s [{"text":"PASS online race_participant indices are within roster bounds"}]
execute unless score #admin_invalid_participants race_state matches 0 run tellraw @s [{"text":"FAIL one or more online race_participant indices are outside roster bounds"}]
execute if data storage advancement_race:match {status:"active"} if score #admin_online_participants race_state = #admin_roster_count race_state run tellraw @s [{"text":"PASS online participant scores cover the active roster"}]
execute if data storage advancement_race:match {status:"active"} if score #admin_online_participants race_state < #admin_roster_count race_state run tellraw @s [{"text":"WARN active roster includes offline or unchecked participants"}]
execute if data storage advancement_race:match {status:"active"} if score #admin_online_participants race_state > #admin_roster_count race_state run tellraw @s [{"text":"FAIL online participant scores exceed active roster size"}]
