execute store result score #museum_elytra race_state run clear @a[scores={race_participant=0..}] minecraft:elytra 0
execute store result score #museum_star race_state run clear @a[scores={race_participant=0..}] minecraft:nether_star 0
execute store result score #museum_head race_state run clear @a[scores={race_participant=0..}] minecraft:dragon_head 0
execute store result score #museum_heart race_state run clear @a[scores={race_participant=0..}] minecraft:heart_of_the_sea 0
execute store result score #museum_totem race_state run clear @a[scores={race_participant=0..}] minecraft:totem_of_undying 0
execute store result score #museum_trident race_state run clear @a[scores={race_participant=0..}] minecraft:trident 0
execute store result score #museum_compass race_state run clear @a[scores={race_participant=0..}] minecraft:recovery_compass 0
scoreboard players set #museum_ready race_state 0
execute if score #museum_elytra race_state matches 1.. run scoreboard players add #museum_ready race_state 1
execute if score #museum_star race_state matches 1.. run scoreboard players add #museum_ready race_state 1
execute if score #museum_head race_state matches 1.. run scoreboard players add #museum_ready race_state 1
execute if score #museum_heart race_state matches 1.. run scoreboard players add #museum_ready race_state 1
execute if score #museum_totem race_state matches 1.. run scoreboard players add #museum_ready race_state 1
execute if score #museum_trident race_state matches 1.. run scoreboard players add #museum_ready race_state 1
execute if score #museum_compass race_state matches 1.. run scoreboard players add #museum_ready race_state 1
execute if score #museum_ready race_state matches 7 run function advancement_race:cooperative/challenges/museum_closing_check/complete
execute unless score #museum_ready race_state matches 7 run tellraw @s [{"text":"Museum Closing Check: ","color":"yellow","bold":true},{"text":"the online team does not currently hold all seven required items.","color":"gray","bold":false}]
