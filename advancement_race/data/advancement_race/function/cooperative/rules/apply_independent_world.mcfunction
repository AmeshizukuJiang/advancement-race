execute if data storage advancement_race:match rules.cooperative.v11.modifiers.independent{no_natural_regeneration:1b} run gamerule minecraft:natural_health_regeneration false
execute unless data storage advancement_race:match rules.cooperative.v11.modifiers.independent{no_natural_regeneration:1b} run gamerule minecraft:natural_health_regeneration true
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.independent{sleepless_nights:1b} run gamerule minecraft:players_sleeping_percentage 101
execute unless data storage advancement_race:match rules.cooperative.v11.modifiers.independent{sleepless_nights:1b} run gamerule minecraft:players_sleeping_percentage 100
