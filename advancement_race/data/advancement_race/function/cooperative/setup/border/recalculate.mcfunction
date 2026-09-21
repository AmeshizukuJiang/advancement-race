scoreboard players set #coop_border_cr race_state 0
execute if data storage advancement_race:match setup.cooperative.modifiers.border{faster_clock:1b} run scoreboard players add #coop_border_cr race_state 2
execute if data storage advancement_race:match setup.cooperative.modifiers.border{tight_start:1b} run scoreboard players add #coop_border_cr race_state 3
execute if data storage advancement_race:match setup.cooperative.modifiers.border{low_ceiling:1b} run scoreboard players add #coop_border_cr race_state 4
execute store result storage advancement_race:match setup.cooperative.modifier_cr.border int 1 run scoreboard players get #coop_border_cr race_state
function advancement_race:cooperative/setup/recalculate_challenge_rating
