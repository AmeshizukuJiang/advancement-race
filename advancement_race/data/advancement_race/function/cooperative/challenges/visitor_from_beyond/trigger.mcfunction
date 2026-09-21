advancement revoke @s only advancement_race_coop:challenge/visitor_from_beyond
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} if score @s race_participant matches 0.. if data storage advancement_race:match cooperative.challenges.visitor_from_beyond{status:"active"} run function advancement_race:cooperative/challenges/visitor_from_beyond/complete
