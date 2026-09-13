execute unless data storage advancement_race:runtime {result:{status:"ready"}} run data modify storage advancement_race:runtime result.query set value {status:"missing_match",records:[]}
execute if data storage advancement_race:runtime {result:{status:"ready"}} run data modify storage advancement_race:runtime result.query set value {records:[]}
execute if data storage advancement_race:runtime {result:{status:"ready"}} run data modify storage advancement_race:runtime result.query.advancement set from storage advancement_race:runtime result_request.advancement
execute if data storage advancement_race:runtime {result:{status:"ready"}} run data modify storage advancement_race:runtime result_work.query_advancement set from storage advancement_race:runtime result_request.advancement
execute if data storage advancement_race:runtime {result:{status:"ready"}} run scoreboard players set #result_query_event_index race_state 0
execute if data storage advancement_race:runtime {result:{status:"ready"}} run data modify storage advancement_race:runtime result_work.query_event_index set value 0
execute if data storage advancement_race:runtime {result:{status:"ready"}} run function advancement_race:result/query_events with storage advancement_race:runtime result_work
