execute unless data storage advancement_race:match {status:"idle",prepared:1b,mode:"cooperative_border"} run tellraw @s [{"text":"Border modifiers can only be changed in a prepared Cooperative Border lobby.","color":"red"}]
execute if data storage advancement_race:match {status:"idle",prepared:1b,mode:"cooperative_border"} run data modify storage advancement_race:match setup.cooperative.modifiers.border.low_ceiling set value 0b
execute if data storage advancement_race:match {status:"idle",prepared:1b,mode:"cooperative_border"} run function advancement_race:cooperative/setup/border/recalculate
execute if data storage advancement_race:match {status:"idle",prepared:1b,mode:"cooperative_border"} run tellraw @s [{"text":"Disabled Border Modifier: Low Ceiling","color":"green"}]
