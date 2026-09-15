data modify storage advancement_race:runtime standings set value {status:"ready",mode:"live",participants:[],events:[]}
data modify storage advancement_race:runtime standings.match_id set from storage advancement_race:runtime status.match_id
data modify storage advancement_race:runtime standings.participants set from storage advancement_race:runtime status.participants
data modify storage advancement_race:runtime standings.events set from storage advancement_race:runtime status.events
