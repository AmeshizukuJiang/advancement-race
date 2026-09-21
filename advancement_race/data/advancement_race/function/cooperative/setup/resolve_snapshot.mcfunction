$data modify storage advancement_race:match rules.cooperative.v11.profile set from storage advancement_race:config cooperative_v11.difficulty_profiles[{level:$(difficulty_level)}]
$data modify storage advancement_race:match rules.cooperative.v11.enabled_challenge_ids set from storage advancement_race:config cooperative_v11.enabled_challenge_ids_by_level[{level:$(difficulty_level)}].ids
