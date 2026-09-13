execute unless data storage advancement_race:match {status:"idle"} run tellraw @s [{"text":"Cannot register: the match is not accepting participants."}]
execute if data storage advancement_race:match {status:"idle"} if score @s race_participant matches 0.. run tellraw @a [{"selector":"@s"},{"text":" is already registered for this match."}]
$execute if data storage advancement_race:match {status:"idle"} unless score @s race_participant matches 0.. run function advancement_race:match/register_new {name:"$(name)"}
