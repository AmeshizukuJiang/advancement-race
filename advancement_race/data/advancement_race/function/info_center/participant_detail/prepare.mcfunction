data remove storage advancement_race:runtime participant_detail
data modify storage advancement_race:runtime participant_detail.source set from storage advancement_race:runtime browser_work.session.source
execute if data storage advancement_race:runtime participant_detail{source:{kind:"current"}} run function advancement_race:status/calculate
$execute if data storage advancement_race:runtime participant_detail{source:{kind:"current"}} if data storage advancement_race:runtime status.participants[$(participant_index)] run data modify storage advancement_race:runtime participant_detail.participant set from storage advancement_race:runtime status.participants[$(participant_index)]
$execute if data storage advancement_race:runtime participant_detail{source:{kind:"history"}} if data storage advancement_race:runtime result.participants[$(participant_index)] run data modify storage advancement_race:runtime participant_detail.participant set from storage advancement_race:runtime result.participants[$(participant_index)]
execute unless data storage advancement_race:runtime participant_detail.participant run tellraw @s [{"text":"This participant is no longer available.","color":"#9B2226"}]
execute if data storage advancement_race:runtime participant_detail.participant run function advancement_race:info_center/participant_detail/show
