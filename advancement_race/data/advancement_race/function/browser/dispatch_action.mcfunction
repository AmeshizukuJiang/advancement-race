execute if data storage advancement_race:runtime browser_work{action:{kind:"history_page"}} run function advancement_race:browser/action/history_page
execute if data storage advancement_race:runtime browser_work{action:{kind:"select_match"}} run function advancement_race:browser/action/select_match
execute if data storage advancement_race:runtime browser_work{action:{kind:"my_result"}} run function advancement_race:browser/action/my_result
execute if score #browser_dispatched race_state matches 0 run function advancement_race:browser/stale
