advancement revoke @s only advancement_race_coop:challenge/end_trading_post
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} if score @s race_participant matches 0.. if data storage advancement_race:match cooperative.challenges.end_trading_post{status:"active"} run function advancement_race:cooperative/challenges/end_trading_post/complete
