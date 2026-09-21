advancement revoke @s only advancement_race_coop:challenge/shoot_down_the_moon_dragon
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} if score @s race_participant matches 0.. if data storage advancement_race:match cooperative.challenges.shoot_down_the_moon{status:"active"} run function advancement_race:cooperative/challenges/shoot_down_the_moon/complete
