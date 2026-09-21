data modify storage advancement_race:match cooperative.challenges.out_of_climate.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.out_of_climate.completed_by set from entity @s UUID
scoreboard players set @a[scores={race_participant=0..}] race_cold_strider 0
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/out_of_climate",title:"Out of Climate"}
function advancement_race:cooperative/challenges/prepare_reward {key:"out_of_climate"}
