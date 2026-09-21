scoreboard players add @s race_death_seen 1
data modify storage advancement_race:runtime cooperative_penalty set value {kind:"modifier_penalty",id:"death_toll",border_delta:-100}
data modify storage advancement_race:runtime cooperative_completion set from storage advancement_race:runtime cooperative_penalty
function advancement_race:cooperative/events/record
tellraw @a [{"text":"Death Toll","color":"red","bold":true},{"text":" | ","color":"gray","bold":false},{"selector":"@s","color":"white"},{"text":" died · Border -100","color":"red"}]
function advancement_race:cooperative/border/apply_penalty
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} if score @s race_deaths > @s race_death_seen run function advancement_race:cooperative/modifiers/death_toll/apply
