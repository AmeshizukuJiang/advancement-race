scoreboard players set #coop_cr_total race_state 0
scoreboard players set #coop_cr_part race_state 0
execute store result score #coop_cr_part race_state run data get storage advancement_race:match setup.cooperative.modifier_cr.difficulty
scoreboard players operation #coop_cr_total race_state += #coop_cr_part race_state
scoreboard players set #coop_cr_part race_state 0
execute store result score #coop_cr_part race_state run data get storage advancement_race:match setup.cooperative.modifier_cr.survival
scoreboard players operation #coop_cr_total race_state += #coop_cr_part race_state
scoreboard players set #coop_cr_part race_state 0
execute store result score #coop_cr_part race_state run data get storage advancement_race:match setup.cooperative.modifier_cr.border
scoreboard players operation #coop_cr_total race_state += #coop_cr_part race_state
scoreboard players set #coop_cr_part race_state 0
execute store result score #coop_cr_part race_state run data get storage advancement_race:match setup.cooperative.modifier_cr.boss
scoreboard players operation #coop_cr_total race_state += #coop_cr_part race_state
scoreboard players set #coop_cr_part race_state 0
execute store result score #coop_cr_part race_state run data get storage advancement_race:match setup.cooperative.modifier_cr.independent
scoreboard players operation #coop_cr_total race_state += #coop_cr_part race_state
execute store result storage advancement_race:match setup.cooperative.challenge_rating int 1 run scoreboard players get #coop_cr_total race_state
