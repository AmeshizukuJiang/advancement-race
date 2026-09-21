data remove storage advancement_race:runtime cooperative_reward
$data modify storage advancement_race:runtime cooperative_reward set from storage advancement_race:config cooperative_v11.vanilla_rewards[{vanilla_id:"$(advancement)"}]
$data modify storage advancement_race:runtime cooperative_completion set value {kind:"vanilla_advancement",id:"$(advancement)",title_translate:"$(title)"}
execute if data storage advancement_race:runtime cooperative_reward run data modify storage advancement_race:runtime cooperative_completion.reward set from storage advancement_race:runtime cooperative_reward.team_points
execute if data storage advancement_race:runtime cooperative_reward run data modify storage advancement_race:runtime cooperative_completion.border_delta set from storage advancement_race:runtime cooperative_reward.border_delta
execute if data storage advancement_race:runtime cooperative_reward run function advancement_race:cooperative/completion/apply
execute unless data storage advancement_race:runtime cooperative_reward run tellraw @s [{"text":"Cooperative reward configuration is missing for this advancement. No team reward was recorded.","color":"red"}]
