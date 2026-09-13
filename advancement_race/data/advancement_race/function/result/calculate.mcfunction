data modify storage advancement_race:runtime result set value {status:"calculating",participants:[],events:[],query:{records:[]}}
data remove storage advancement_race:runtime result_source
data remove storage advancement_race:runtime result_work
execute if data storage advancement_race:runtime result_request.match_id run function advancement_race:result/select_match with storage advancement_race:runtime result_request
execute unless data storage advancement_race:runtime result_request.match_id run function advancement_race:result/select_latest
execute unless data storage advancement_race:runtime result_source run data modify storage advancement_race:runtime result.status set value "missing_match"
execute if data storage advancement_race:runtime result_source run function advancement_race:result/build
