$data modify storage advancement_race:runtime advancement_index set value {status:"building",mode:"final",match_id:$(match_id)}
$function advancement_race:result/calculate_match {match_id:$(match_id)}
$execute if data storage advancement_race:runtime result{status:"ready",match_id:$(match_id)} run function advancement_race:advancement_index/copy_from_result
$execute if data storage advancement_race:runtime advancement_index{status:"ready",mode:"final",match_id:$(match_id)} run function advancement_race:advancement_index_book/open
$execute unless data storage advancement_race:runtime advancement_index{status:"ready",mode:"final",match_id:$(match_id)} run tellraw @s [{"text":"The Advancement Index is not available for this match.","color":"red"}]
