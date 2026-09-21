execute if data storage advancement_race:runtime browser_work{session:{view:"info_center",source:{kind:"current"}}} if data storage advancement_race:match {status:"active",mode:"cooperative_border"} run scoreboard players set #browser_dispatched race_state 1
execute if score #browser_dispatched race_state matches 1 run function advancement_race:cooperative/challenges/automation_is_not_magic/submit_fireworks
execute if score #browser_dispatched race_state matches 1 run function advancement_race:info_center/open
