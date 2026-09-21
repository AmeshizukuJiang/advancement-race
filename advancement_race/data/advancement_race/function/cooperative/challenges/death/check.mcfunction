execute as @a[tag=advancement_race_n3_firework_pending] if data storage advancement_race:match cooperative.challenges.splendid_as_summer_flowers{status:"active"} if score @s race_deaths > @s race_challenge_death_seen run function advancement_race:cooperative/challenges/splendid_as_summer_flowers/complete
execute as @a[tag=advancement_race_n3_slumber_overworld_pending] if data storage advancement_race:match cooperative.challenges.eternal_slumber{status:"active",overworld:0b} if score @s race_deaths > @s race_challenge_death_seen run function advancement_race:cooperative/challenges/eternal_slumber/mark_overworld
execute as @a[tag=advancement_race_n3_slumber_nether_pending] if data storage advancement_race:match cooperative.challenges.eternal_slumber{status:"active",nether:0b} if score @s race_deaths > @s race_challenge_death_seen run function advancement_race:cooperative/challenges/eternal_slumber/mark_nether
execute as @a[tag=advancement_race_n3_slumber_end_pending] if data storage advancement_race:match cooperative.challenges.eternal_slumber{status:"active",end:0b} if score @s race_deaths > @s race_challenge_death_seen run function advancement_race:cooperative/challenges/eternal_slumber/mark_end
execute as @a[tag=advancement_race_n9_border_overworld_pending] if data storage advancement_race:match cooperative.challenges.still_not_fast_enough{status:"active",overworld:0b} if score @s race_deaths > @s race_challenge_death_seen run function advancement_race:cooperative/challenges/still_not_fast_enough/mark_overworld
execute as @a[tag=advancement_race_n9_border_nether_pending] if data storage advancement_race:match cooperative.challenges.still_not_fast_enough{status:"active",nether:0b} if score @s race_deaths > @s race_challenge_death_seen run function advancement_race:cooperative/challenges/still_not_fast_enough/mark_nether
execute as @a[tag=advancement_race_n9_border_end_pending] if data storage advancement_race:match cooperative.challenges.still_not_fast_enough{status:"active",end:0b} if score @s race_deaths > @s race_challenge_death_seen run function advancement_race:cooperative/challenges/still_not_fast_enough/mark_end
tag @a remove advancement_race_n3_firework_pending
tag @a remove advancement_race_n3_slumber_overworld_pending
tag @a remove advancement_race_n3_slumber_nether_pending
tag @a remove advancement_race_n3_slumber_end_pending
tag @a remove advancement_race_n9_border_overworld_pending
tag @a remove advancement_race_n9_border_nether_pending
tag @a remove advancement_race_n9_border_end_pending
