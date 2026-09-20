data modify storage advancement_race:runtime info_center set value {status:"building",pages:[],registered:0b,player_count:0}
data modify storage advancement_race:runtime info_center.source set value {kind:"current"}
data modify storage advancement_race:runtime info_center.match_id set from storage advancement_race:match id
data modify storage advancement_race:runtime info_center.match_status set from storage advancement_race:match status
data modify storage advancement_race:runtime info_center.prepared set from storage advancement_race:match prepared
data modify storage advancement_race:runtime info_center.participants set from storage advancement_race:match participants
data modify storage advancement_race:runtime info_center.player_uuid set from entity @s UUID
execute store result score #info_center_player_count race_state run data get storage advancement_race:match participants
execute store result storage advancement_race:runtime info_center.player_count int 1 run scoreboard players get #info_center_player_count race_state
execute if score @s race_participant matches 0.. run data modify storage advancement_race:runtime info_center.registered set value 1b
data modify storage advancement_race:runtime browser_request set value {view:"info_center",source:{kind:"current"}}
function advancement_race:browser/session/begin
execute if data storage advancement_race:match {status:"idle",prepared:1b,mode:"cooperative_border"} if score @s race_participant matches 0.. run function advancement_race:cooperative/ui/build_lobby_registered
execute if data storage advancement_race:match {status:"idle",prepared:1b,mode:"cooperative_border"} unless score @s race_participant matches 0.. run function advancement_race:cooperative/ui/build_lobby_unregistered
execute if data storage advancement_race:match {status:"idle",prepared:1b} unless data storage advancement_race:match {mode:"cooperative_border"} if score @s race_participant matches 0.. run function advancement_race:info_center/build_lobby_registered with storage advancement_race:runtime info_center
execute if data storage advancement_race:match {status:"idle",prepared:1b} unless data storage advancement_race:match {mode:"cooperative_border"} unless score @s race_participant matches 0.. run function advancement_race:info_center/build_lobby_unregistered with storage advancement_race:runtime info_center
execute if data storage advancement_race:match {status:"idle",prepared:0b} run function advancement_race:info_center/build_unprepared with storage advancement_race:runtime info_center
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} if score @s race_participant matches 0.. run function advancement_race:cooperative/ui/build_active_participant
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} unless score @s race_participant matches 0.. run function advancement_race:cooperative/ui/build_active_observer
execute if data storage advancement_race:match {status:"active"} unless data storage advancement_race:match {mode:"cooperative_border"} if score @s race_participant matches 0.. run function advancement_race:info_center/build_active_participant
execute if data storage advancement_race:match {status:"active"} unless data storage advancement_race:match {mode:"cooperative_border"} unless score @s race_participant matches 0.. run function advancement_race:info_center/build_active_observer with storage advancement_race:runtime info_center
execute if data storage advancement_race:match {status:"ended"} run function advancement_race:info_center/build_ended with storage advancement_race:runtime info_center
execute unless data storage advancement_race:match {status:"idle"} unless data storage advancement_race:match {status:"active"} unless data storage advancement_race:match {status:"ended"} run function advancement_race:info_center/build_unavailable
execute if data storage advancement_race:runtime info_center{status:"ready"} run function advancement_race:browser/session/finalize
execute if data storage advancement_race:runtime info_center{status:"ready"} run function advancement_race:info_center/deliver
