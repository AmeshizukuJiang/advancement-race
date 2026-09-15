execute store result score #info_center_used_slots race_state run data get entity @s Inventory
execute if data entity @s Inventory[{Slot:100b}] run scoreboard players remove #info_center_used_slots race_state 1
execute if data entity @s Inventory[{Slot:101b}] run scoreboard players remove #info_center_used_slots race_state 1
execute if data entity @s Inventory[{Slot:102b}] run scoreboard players remove #info_center_used_slots race_state 1
execute if data entity @s Inventory[{Slot:103b}] run scoreboard players remove #info_center_used_slots race_state 1
execute if data entity @s Inventory[{Slot:-106b}] run scoreboard players remove #info_center_used_slots race_state 1
execute if score #info_center_used_slots race_state matches ..35 run function advancement_race:info_center/give_item with storage advancement_race:runtime info_center
execute if score #info_center_used_slots race_state matches ..35 run title @s actionbar {"text":"Info Center refreshed — right-click to reopen.","color":"#8A6500"}
execute if score #info_center_used_slots race_state matches 36.. run tellraw @s [{"text":"Your inventory is full. Free one inventory or hotbar slot, then use ","color":"#9B2226"},{"text":"/trigger race_menu","color":"#8A6500"},{"text":" again.","color":"#9B2226"}]
