execute as @a[scores={race_menu=2}] run function advancement_race:book/lobby
execute as @a[scores={race_menu=3}] run function advancement_race:book/status
execute as @a[scores={race_menu=4}] run function advancement_race:vote/end
execute as @a[scores={race_menu=5}] run function advancement_race:book/result_latest
execute as @a[scores={race_menu=1}] run function advancement_race:menu/open
execute as @a[scores={race_menu=6..}] run function advancement_race:menu/open
scoreboard players set @a race_menu 0
scoreboard players enable @a race_menu
