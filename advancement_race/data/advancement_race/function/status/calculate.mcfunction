data modify storage advancement_race:runtime status set value {status:"calculating",participants:[],events:[]}
data remove storage advancement_race:runtime status_work
execute unless data storage advancement_race:match {status:"active"} run data modify storage advancement_race:runtime status.status set value "missing_active_match"
execute if data storage advancement_race:match {status:"active"} run function advancement_race:status/build
