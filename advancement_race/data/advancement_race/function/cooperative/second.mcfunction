scoreboard players set #coop_tick race_state 0
execute as @a[scores={race_participant=0..}] run function advancement_race:cooperative/rules/apply_survival_player
scoreboard players add #coop_duration_ticks race_state 20
execute store result storage advancement_race:match cooperative.duration_ticks int 1 run scoreboard players get #coop_duration_ticks race_state
execute if data storage advancement_race:match cooperative.challenges.relay{status:"active"} run function advancement_race:cooperative/challenges/relay/tick
execute if data storage advancement_race:match cooperative.challenges.eternal_slumber{status:"active"} run function advancement_race:cooperative/challenges/eternal_slumber/tick
execute if data storage advancement_race:match cooperative.challenges.ecological_restoration{status:"active"} run function advancement_race:cooperative/challenges/ecological_restoration/tick
execute if data storage advancement_race:match cooperative.challenges.something_is_wrong{status:"active"} run function advancement_race:cooperative/challenges/something_is_wrong/tick
execute if data storage advancement_race:match cooperative.challenges.relay_ii{status:"active"} run function advancement_race:cooperative/challenges/relay_ii/tick
execute if data storage advancement_race:match cooperative.challenges.ascend_the_soul{status:"active"} run function advancement_race:cooperative/challenges/ascend_the_soul/scan
execute if data storage advancement_race:match cooperative.challenges.alien_froglight{status:"active"} run function advancement_race:cooperative/challenges/alien_froglight/scan
execute if data storage advancement_race:match cooperative.challenges.three_realm_finale{status:"active"} run function advancement_race:cooperative/challenges/three_realm_finale/tick
execute if data storage advancement_race:match cooperative.challenges.still_not_fast_enough{status:"active"} run function advancement_race:cooperative/challenges/still_not_fast_enough/tick
execute if data storage advancement_race:match cooperative.challenges.flowers_beyond{status:"active"} run function advancement_race:cooperative/challenges/flowers_beyond/tick
execute if data storage advancement_race:match cooperative.challenges.foreign_crusade{status:"active"} run function advancement_race:cooperative/challenges/foreign_crusade/tick
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} run function advancement_race:cooperative/border/tick
