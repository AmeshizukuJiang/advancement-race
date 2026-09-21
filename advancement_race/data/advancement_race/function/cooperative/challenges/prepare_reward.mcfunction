data remove storage advancement_race:runtime cooperative_reward
$data modify storage advancement_race:runtime cooperative_reward set from storage advancement_race:config cooperative_v11.custom_challenges[{key:"$(key)"}]
execute if data storage advancement_race:runtime cooperative_reward run data modify storage advancement_race:runtime cooperative_completion.reward set from storage advancement_race:runtime cooperative_reward.team_points
execute if data storage advancement_race:runtime cooperative_reward run data modify storage advancement_race:runtime cooperative_completion.border_delta set from storage advancement_race:runtime cooperative_reward.border_delta
execute if data storage advancement_race:runtime cooperative_reward if data storage advancement_race:match rules.cooperative.v11{difficulty_level:18} run data modify storage advancement_race:runtime cooperative_completion.border_delta set value -50
execute if data storage advancement_race:runtime cooperative_reward run function advancement_race:cooperative/completion/apply
execute unless data storage advancement_race:runtime cooperative_reward run tellraw @s [{"text":"Cooperative challenge reward configuration is missing. No team reward was recorded.","color":"red"}]
