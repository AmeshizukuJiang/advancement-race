advancement revoke @s only advancement_race_coop:challenge/into_the_nightmare
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} if score @s race_participant matches 0.. if data storage advancement_race:match cooperative.challenges.into_the_nightmare{status:"active"} run function advancement_race:cooperative/challenges/into_the_nightmare/complete
