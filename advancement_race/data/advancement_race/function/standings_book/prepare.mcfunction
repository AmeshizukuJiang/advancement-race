data modify storage advancement_race:runtime standings_book set value {status:"building",participants:[],pages:[]}
data modify storage advancement_race:runtime standings_book.mode set from storage advancement_race:runtime standings.mode
data modify storage advancement_race:runtime standings_book.match_id set from storage advancement_race:runtime standings.match_id
data modify storage advancement_race:runtime standings_book.participants set from storage advancement_race:runtime standings.participants
execute if data storage advancement_race:runtime standings_book{mode:"live"} run data modify storage advancement_race:runtime browser_request set value {view:"standings",source:{kind:"live"}}
execute if data storage advancement_race:runtime standings_book{mode:"final"} run data modify storage advancement_race:runtime browser_request set value {view:"standings",source:{kind:"history"}}
data modify storage advancement_race:runtime browser_request.source.match_id set from storage advancement_race:runtime standings_book.match_id
function advancement_race:browser/session/begin
function advancement_race:standings_book/build
function advancement_race:browser/session/finalize
function advancement_race:standings_book/give_item with storage advancement_race:runtime standings_book
