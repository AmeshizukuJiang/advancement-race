data modify storage advancement_race:runtime advancement_results_source set value {status:"building",mode:"live"}
execute unless data storage advancement_race:match {status:"active"} run tellraw @s [{"text":"Advancement Results are available only during an active match.","color":"red"}]
execute if data storage advancement_race:match {status:"active"} run function advancement_race:status/calculate
execute if data storage advancement_race:match {status:"active"} if data storage advancement_race:runtime status{status:"ready"} run function advancement_race:advancement_results/copy_from_status
execute if data storage advancement_race:runtime advancement_results_source{status:"ready",mode:"live"} run function advancement_race:advancement_results/open
execute if data storage advancement_race:match {status:"active"} unless data storage advancement_race:runtime advancement_results_source{status:"ready",mode:"live"} run tellraw @s [{"text":"Advancement Results are not available for this match.","color":"red"}]
