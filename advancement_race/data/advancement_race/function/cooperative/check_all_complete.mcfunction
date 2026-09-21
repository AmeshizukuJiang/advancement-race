execute store result score #coop_vanilla_completed race_state run data get storage advancement_race:match cooperative.vanilla_completed
execute store result score #coop_challenge_completed race_state run data get storage advancement_race:match cooperative.challenge_completed
scoreboard players set #coop_required_custom race_state 0
execute store result score #coop_required_custom race_state run data get storage advancement_race:match rules.cooperative.v11.required_custom_challenges
execute if score #coop_vanilla_completed race_state matches 121.. if score #coop_challenge_completed race_state >= #coop_required_custom race_state run data modify storage advancement_race:match end_reason set value "all_goals_completed"
execute if score #coop_vanilla_completed race_state matches 121.. if score #coop_challenge_completed race_state >= #coop_required_custom race_state run function advancement_race:match/end_apply
