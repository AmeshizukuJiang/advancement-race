execute unless data storage advancement_race:match {status:"active"} run tellraw @s [{"text":"Cannot vote: no active match is running."}]
execute if data storage advancement_race:match {status:"active"} unless score @s race_participant matches 0.. run tellraw @s [{"text":"Cannot vote: only registered participants may vote."}]
execute if data storage advancement_race:match {status:"active"} if score @s race_participant matches 0.. run function advancement_race:vote/prepare
execute if data storage advancement_race:match {status:"active"} if score @s race_participant matches 0.. run execute store result storage advancement_race:runtime vote_work.participant_index int 1 run scoreboard players get @s race_participant
execute if data storage advancement_race:match {status:"active"} if score @s race_participant matches 0.. run function advancement_race:vote/cast with storage advancement_race:runtime vote_work
