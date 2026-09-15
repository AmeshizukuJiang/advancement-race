data modify storage advancement_race:runtime standings_detail set value {status:"building",events:[],pages:[]}
data modify storage advancement_race:runtime standings_detail_work set value {}
data modify storage advancement_race:runtime standings_detail.source set from storage advancement_race:runtime standings_request.source
$execute if data storage advancement_race:runtime standings.participants[$(participant_index)] run data modify storage advancement_race:runtime standings_detail.participant set from storage advancement_race:runtime standings.participants[$(participant_index)]
$execute if data storage advancement_race:runtime standings.participants[$(participant_index)] run data modify storage advancement_race:runtime standings_detail.participant_index set value $(participant_index)
execute unless data storage advancement_race:runtime standings_detail.participant run tellraw @s [{"text":"This participant is no longer available.","color":"red"}]
execute if data storage advancement_race:runtime standings_detail.participant run function advancement_race:standings_detail/prepare
