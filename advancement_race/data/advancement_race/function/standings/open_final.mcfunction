$function advancement_race:result/calculate_match {match_id:$(match_id)}
$execute if data storage advancement_race:runtime {result:{status:"ready",match_id:$(match_id)}} run function advancement_race:standings/copy_from_result
$execute if data storage advancement_race:runtime {standings:{status:"ready",mode:"final",match_id:$(match_id)}} run function advancement_race:standings_book/open
$execute unless data storage advancement_race:runtime {standings:{status:"ready",mode:"final",match_id:$(match_id)}} run tellraw @s [{"text":"Final Standings are not available for this match.","color":"red"}]
