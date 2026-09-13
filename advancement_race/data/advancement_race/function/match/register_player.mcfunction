execute if score @s race_participant matches 0.. run tellraw @a [{"selector":"@s"},{"text":" is already registered for this match."}]
$execute unless score @s race_participant matches 0.. run function advancement_race:match/register_new {name:"$(name)"}
