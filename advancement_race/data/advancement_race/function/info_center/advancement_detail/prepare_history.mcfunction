$function advancement_race:result/calculate_match {match_id:$(match_id)}
$execute if data storage advancement_race:runtime result{status:"ready",match_id:$(match_id)} run data modify storage advancement_race:runtime advancement_detail.valid set value 1b
$execute if data storage advancement_race:runtime result{status:"ready",match_id:$(match_id)} run data modify storage advancement_race:runtime advancement_detail.events append from storage advancement_race:runtime result.events[{advancement:"$(advancement)"}]
$execute if data storage advancement_race:runtime result{status:"ready",match_id:$(match_id)} store result score #advancement_detail_roster race_state run data get storage advancement_race:runtime result.participants
