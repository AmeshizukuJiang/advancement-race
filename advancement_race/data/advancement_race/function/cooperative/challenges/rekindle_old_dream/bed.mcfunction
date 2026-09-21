advancement revoke @s only advancement_race_coop:challenge/rekindle_old_dream_bed
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} if score @s race_participant matches 0.. if data storage advancement_race:match cooperative.challenges.rekindle_old_dream{status:"armed"} run function advancement_race:cooperative/challenges/rekindle_old_dream/watch
