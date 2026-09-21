scoreboard players set #coop_independent_cr race_state 0
execute if data storage advancement_race:match setup.cooperative.modifiers.independent{no_natural_regeneration:1b} run scoreboard players add #coop_independent_cr race_state 3
execute if data storage advancement_race:match setup.cooperative.modifiers.independent{sleepless_nights:1b} run scoreboard players add #coop_independent_cr race_state 2
execute if data storage advancement_race:match setup.cooperative.modifiers.independent{death_toll:1b} run scoreboard players add #coop_independent_cr race_state 3
execute if data storage advancement_race:match setup.cooperative.modifiers.independent{failure_tax:1b} run scoreboard players add #coop_independent_cr race_state 3
execute if data storage advancement_race:match setup.cooperative.modifiers.independent{no_offline_pause:1b} run scoreboard players add #coop_independent_cr race_state 2
execute store result storage advancement_race:match setup.cooperative.modifier_cr.independent int 1 run scoreboard players get #coop_independent_cr race_state
function advancement_race:cooperative/setup/recalculate_challenge_rating
