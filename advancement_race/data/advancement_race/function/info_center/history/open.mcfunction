execute unless data storage advancement_race:history matches[0] run tellraw @s [{"text":"No completed races are available yet.","color":"#9A5B00"}]
execute if data storage advancement_race:history matches[0] run data modify storage advancement_race:runtime browser_request set value {view:"info_center_history",source:{kind:"history_list"},page:0}
execute if data storage advancement_race:history matches[0] run function advancement_race:info_center/history/open_page
