execute if data storage advancement_race:match rules.cooperative.v11.modifiers{survival:"standard"} run attribute @s minecraft:max_health base set 20
execute if data storage advancement_race:match rules.cooperative.v11.modifiers{survival:"standard"} run tag @s remove advancement_race_survival_modified
execute if data storage advancement_race:match rules.cooperative.v11.modifiers{survival:"death_drops"} run attribute @s minecraft:max_health base set 20
execute if data storage advancement_race:match rules.cooperative.v11.modifiers{survival:"death_drops"} run tag @s remove advancement_race_survival_modified
execute if data storage advancement_race:match rules.cooperative.v11.modifiers{survival:"wounded"} run attribute @s minecraft:max_health base set 18
execute if data storage advancement_race:match rules.cooperative.v11.modifiers{survival:"wounded"} run tag @s add advancement_race_survival_modified
execute if data storage advancement_race:match rules.cooperative.v11.modifiers{survival:"half_health"} run attribute @s minecraft:max_health base set 10
execute if data storage advancement_race:match rules.cooperative.v11.modifiers{survival:"half_health"} run tag @s add advancement_race_survival_modified
execute if data storage advancement_race:match rules.cooperative.v11.modifiers{survival:"one_heart"} run attribute @s minecraft:max_health base set 2
execute if data storage advancement_race:match rules.cooperative.v11.modifiers{survival:"one_heart"} run tag @s add advancement_race_survival_modified
