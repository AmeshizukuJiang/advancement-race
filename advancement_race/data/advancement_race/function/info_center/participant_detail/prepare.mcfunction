data remove storage advancement_race:runtime participant_detail
data modify storage advancement_race:runtime participant_detail.source set from storage advancement_race:runtime browser_work.session.source
$data modify storage advancement_race:runtime participant_detail.participant_index set value $(participant_index)
execute if data storage advancement_race:runtime participant_detail{source:{kind:"current"}} run data modify storage advancement_race:runtime participant_detail.match_id set from storage advancement_race:match id
execute if data storage advancement_race:runtime participant_detail{source:{kind:"history"}} run data modify storage advancement_race:runtime participant_detail.match_id set from storage advancement_race:runtime participant_detail.source.match_id
execute if data storage advancement_race:runtime participant_detail{source:{kind:"current"}} run function advancement_race:status/calculate
$execute if data storage advancement_race:runtime participant_detail{source:{kind:"current"}} if data storage advancement_race:runtime status.participants[$(participant_index)] run data modify storage advancement_race:runtime participant_detail.participant set from storage advancement_race:runtime status.participants[$(participant_index)]
execute if data storage advancement_race:runtime participant_detail{source:{kind:"history"}} if data storage advancement_race:runtime participant_detail.match_id run function advancement_race:info_center/participant_detail/prepare_history with storage advancement_race:runtime participant_detail
execute unless data storage advancement_race:runtime participant_detail.participant run tellraw @s [{"text":"This participant is no longer available.","color":"#9B2226"}]
execute if data storage advancement_race:runtime participant_detail.participant run function advancement_race:info_center/participant_detail/show
