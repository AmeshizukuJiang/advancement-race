$function advancement_race:result/calculate_match {match_id:$(match_id)}
$execute if data storage advancement_race:runtime {result:{status:"ready",match_id:$(match_id)}} run function advancement_race:standings/copy_from_result
$execute if data storage advancement_race:runtime {standings:{status:"ready",mode:"final",match_id:$(match_id)}} run function advancement_race:standings_detail/open with storage advancement_race:runtime standings_request
$execute unless data storage advancement_race:runtime {standings:{status:"ready",mode:"final",match_id:$(match_id)}} run tellraw @s [{"text":"Participant Detail is not available for this match.","color":"red"}]
