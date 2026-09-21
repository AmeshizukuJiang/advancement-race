execute store result storage advancement_race:match cooperative.team_points int 1 run scoreboard players get #coop_team_points race_state
execute store result storage advancement_race:match cooperative.duration_ticks int 1 run scoreboard players get #coop_duration_ticks race_state
execute store result storage advancement_race:match cooperative.border.size_milli int 1 run scoreboard players get #coop_border_milli race_state
function advancement_race:cooperative/challenges/three_realm_finale/cleanup_targets
tag @a remove advancement_race_n9_border_overworld_pending
tag @a remove advancement_race_n9_border_nether_pending
tag @a remove advancement_race_n9_border_end_pending
function advancement_race:cooperative/challenges/three_realm_merchant/cleanup_target
function advancement_race:cooperative/challenges/shoot_down_the_moon/cleanup_target
function advancement_race:cooperative/challenges/jailer_unemployed/cleanup_targets
function advancement_race:cooperative/challenges/rekindle_old_dream/cleanup
function advancement_race:cooperative/challenges/foreign_crusade/cleanup_targets
data modify storage advancement_race:match duration_ticks set from storage advancement_race:match cooperative.duration_ticks
tellraw @a [{"text":"Cooperative result: ","color":"aqua","bold":true},{"text":"reason ","color":"gray","bold":false},{"storage":"advancement_race:match","nbt":"end_reason","color":"yellow"},{"text":" · team points ","color":"gray"},{"storage":"advancement_race:match","nbt":"cooperative.team_points","color":"gold"}]
