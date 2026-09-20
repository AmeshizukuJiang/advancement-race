execute store result score #coop_reward race_state run data get storage advancement_race:runtime cooperative_completion.reward
scoreboard players operation #coop_team_points race_state += #coop_reward race_state
execute store result storage advancement_race:match cooperative.team_points int 1 run scoreboard players get #coop_team_points race_state
execute if data storage advancement_race:runtime cooperative_completion{kind:"vanilla_advancement"} run scoreboard players add #coop_vanilla_completed race_state 1
execute if data storage advancement_race:runtime cooperative_completion{kind:"challenge"} run scoreboard players add #coop_challenge_completed race_state 1
execute store result storage advancement_race:match cooperative.vanilla_completed int 1 run scoreboard players get #coop_vanilla_completed race_state
execute store result storage advancement_race:match cooperative.challenge_completed int 1 run scoreboard players get #coop_challenge_completed race_state
function advancement_race:cooperative/events/record
data modify storage advancement_race:match cooperative.completed append from storage advancement_race:runtime cooperative_event
function advancement_race:cooperative/border/add_reward
execute if data storage advancement_race:runtime cooperative_completion{kind:"vanilla_advancement"} run function advancement_race:cooperative/completion/announce_vanilla with storage advancement_race:runtime cooperative_completion
execute if data storage advancement_race:runtime cooperative_completion{kind:"challenge"} run function advancement_race:cooperative/completion/announce_challenge with storage advancement_race:runtime cooperative_completion
function advancement_race:cooperative/check_all_complete
