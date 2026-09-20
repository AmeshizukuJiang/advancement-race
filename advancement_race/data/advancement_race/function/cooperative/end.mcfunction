execute store result storage advancement_race:match cooperative.team_points int 1 run scoreboard players get #coop_team_points race_state
execute store result storage advancement_race:match cooperative.duration_ticks int 1 run scoreboard players get #coop_duration_ticks race_state
execute store result storage advancement_race:match cooperative.border.size_milli int 1 run scoreboard players get #coop_border_milli race_state
data modify storage advancement_race:match duration_ticks set from storage advancement_race:match cooperative.duration_ticks
tellraw @a [{"text":"Cooperative result: ","color":"aqua","bold":true},{"text":"reason ","color":"gray","bold":false},{"storage":"advancement_race:match","nbt":"end_reason","color":"yellow"},{"text":" · team points ","color":"gray"},{"storage":"advancement_race:match","nbt":"cooperative.team_points","color":"gold"}]
