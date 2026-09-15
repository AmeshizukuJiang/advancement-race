$data modify storage advancement_race:runtime advancement_results_source set value {status:"building",mode:"final",match_id:$(match_id)}
$function advancement_race:result/calculate_match {match_id:$(match_id)}
$execute if data storage advancement_race:runtime result{status:"ready",match_id:$(match_id)} run function advancement_race:advancement_results/copy_from_result
$execute if data storage advancement_race:runtime advancement_results_source{status:"ready",mode:"final",match_id:$(match_id)} run function advancement_race:advancement_results/open
$execute unless data storage advancement_race:runtime advancement_results_source{status:"ready",mode:"final",match_id:$(match_id)} run tellraw @s [{"text":"Advancement Results are not available for this match.","color":"red"}]
