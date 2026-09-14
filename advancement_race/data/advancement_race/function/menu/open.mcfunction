execute if data storage advancement_race:match {status:"idle",prepared:1b} if score @s race_participant matches 0.. run function advancement_race:menu/show_lobby_registered
execute if data storage advancement_race:match {status:"idle",prepared:1b} unless score @s race_participant matches 0.. run function advancement_race:menu/show_lobby_unregistered
execute if data storage advancement_race:match {status:"idle",prepared:0b} run function advancement_race:menu/show_unprepared
execute if data storage advancement_race:match {status:"active"} if score @s race_participant matches 0.. run function advancement_race:menu/show_active_participant
execute if data storage advancement_race:match {status:"active"} unless score @s race_participant matches 0.. run function advancement_race:menu/show_active_observer
execute if data storage advancement_race:match {status:"ended"} run function advancement_race:menu/show_ended
execute unless data storage advancement_race:match {status:"idle"} unless data storage advancement_race:match {status:"active"} unless data storage advancement_race:match {status:"ended"} run tellraw @s [{"text":"[Advancement Race] ","color":"gold","bold":true},{"text":"The match state is unavailable. Ask the host for help.","color":"red","bold":false}]
