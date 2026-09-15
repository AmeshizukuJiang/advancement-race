scoreboard players set #info_center_mainhand_marked race_state 0
execute if items entity @s weapon.mainhand minecraft:written_book[minecraft:custom_data~{advancement_race:{ui_book:1b}}] run scoreboard players set #info_center_mainhand_marked race_state 1
execute store result score #info_center_old_books race_state run clear @s minecraft:written_book[minecraft:custom_data~{advancement_race:{ui_book:1b}}] 0
clear @s minecraft:written_book[minecraft:custom_data~{advancement_race:{ui_book:1b}}]
execute if score #info_center_mainhand_marked race_state matches 1 run function advancement_race:info_center/replace_mainhand with storage advancement_race:runtime info_center
execute unless score #info_center_mainhand_marked race_state matches 1 run function advancement_race:info_center/deliver_to_inventory
execute if score #info_center_mainhand_marked race_state matches 1 run title @s actionbar {"text":"Info Center refreshed — right-click to reopen.","color":"#8A6500"}
