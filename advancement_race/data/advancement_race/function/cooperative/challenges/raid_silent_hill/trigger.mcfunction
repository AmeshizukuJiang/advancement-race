advancement revoke @s only advancement_race_coop:challenge/raid_silent_hill
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} if score @s race_participant matches 0.. if data storage advancement_race:match cooperative.challenges.raid_silent_hill{status:"active"} run function advancement_race:cooperative/challenges/raid_silent_hill/complete
