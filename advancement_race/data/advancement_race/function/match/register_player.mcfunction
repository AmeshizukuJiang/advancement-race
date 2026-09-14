execute unless data storage advancement_race:match {status:"idle"} run tellraw @s [{"text":"Registration is closed because a match is already in progress or has ended.","color":"red"}]
execute if data storage advancement_race:match {status:"idle"} if score @s race_participant matches 0.. run tellraw @s [{"text":"You are already registered for this match.","color":"yellow"}]
$execute if data storage advancement_race:match {status:"idle"} unless score @s race_participant matches 0.. run function advancement_race:match/register_new {name:"$(name)"}
