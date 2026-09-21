execute if dimension minecraft:overworld if data storage advancement_race:match cooperative.challenges.still_not_fast_enough{overworld:0b} run tag @s add advancement_race_n9_border_overworld_pending
execute if dimension minecraft:the_nether if data storage advancement_race:match cooperative.challenges.still_not_fast_enough{nether:0b} run tag @s add advancement_race_n9_border_nether_pending
execute if dimension minecraft:the_end if data storage advancement_race:match cooperative.challenges.still_not_fast_enough{end:0b} run tag @s add advancement_race_n9_border_end_pending
execute if entity @s[tag=advancement_race_n9_border_overworld_pending] run schedule function advancement_race:cooperative/challenges/death/check 1t replace
execute if entity @s[tag=advancement_race_n9_border_nether_pending] run schedule function advancement_race:cooperative/challenges/death/check 1t replace
execute if entity @s[tag=advancement_race_n9_border_end_pending] run schedule function advancement_race:cooperative/challenges/death/check 1t replace
