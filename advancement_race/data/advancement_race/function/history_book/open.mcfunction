execute unless data storage advancement_race:history matches[0] run function advancement_race:browser/session/invalidate_current
execute unless data storage advancement_race:history matches[0] run tellraw @s [{"text":"No completed races are available yet.","color":"yellow"}]
execute if data storage advancement_race:history matches[0] run data modify storage advancement_race:runtime browser_request set value {view:"history",page:0}
execute if data storage advancement_race:history matches[0] run function advancement_race:history_book/open_page
