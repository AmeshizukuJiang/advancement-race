advancement revoke @s only advancement_race_coop:challenge/sleep_above_clouds
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} if score @s race_participant matches 0.. if data storage advancement_race:match cooperative.challenges.sleep_above_clouds{status:"active"} run function advancement_race:cooperative/challenges/sleep_above_clouds/complete
