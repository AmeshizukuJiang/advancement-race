execute as @a[scores={race_menu=1..8}] run function advancement_race:menu/open
execute as @a[scores={race_menu=9}] run function advancement_race:info_center/history/open
execute as @a[scores={race_menu=10..999}] run function advancement_race:menu/open
execute as @a[scores={race_menu=1000..}] run function advancement_race:browser/dispatch_dynamic
scoreboard players set @a race_menu 0
scoreboard players enable @a race_menu
