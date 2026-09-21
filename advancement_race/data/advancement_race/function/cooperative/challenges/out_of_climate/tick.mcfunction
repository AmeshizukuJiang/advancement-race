execute as @a[scores={race_participant=0..},advancements={advancement_race_coop:challenge/out_of_climate=true}] run scoreboard players add @s race_cold_strider 1
execute as @a[scores={race_participant=0..},advancements={advancement_race_coop:challenge/out_of_climate=false}] run scoreboard players set @s race_cold_strider 0
advancement revoke @a[scores={race_participant=0..}] only advancement_race_coop:challenge/out_of_climate
execute as @a[scores={race_participant=0..,race_cold_strider=600..},limit=1,sort=arbitrary] if data storage advancement_race:match cooperative.challenges.out_of_climate{status:"active"} run function advancement_race:cooperative/challenges/out_of_climate/complete
