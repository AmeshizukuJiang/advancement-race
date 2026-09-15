data modify storage advancement_race:runtime advancement_category_request set value {}
data modify storage advancement_race:runtime advancement_category_request.source set from storage advancement_race:runtime browser_work.session.source
data modify storage advancement_race:runtime advancement_category_request.category set from storage advancement_race:runtime browser_work.action.category
data modify storage advancement_race:runtime advancement_category_request.category_title set from storage advancement_race:runtime browser_work.action.category_title
data modify storage advancement_race:runtime advancement_category_request.category_count set from storage advancement_race:runtime browser_work.action.category_count
execute if data storage advancement_race:runtime browser_work.session.source.match_id run data modify storage advancement_race:runtime advancement_category_request.match_id set from storage advancement_race:runtime browser_work.session.source.match_id
execute if data storage advancement_race:runtime browser_work{session:{view:"advancement_index",source:{kind:"live"}},action:{kind:"advancement_category"}} run scoreboard players set #browser_dispatched race_state 1
execute if data storage advancement_race:runtime browser_work{session:{view:"advancement_index",source:{kind:"live"}},action:{kind:"advancement_category"}} run function advancement_race:advancement_category_book/open
execute if data storage advancement_race:runtime browser_work{session:{view:"advancement_index",source:{kind:"history"}},action:{kind:"advancement_category"}} run function advancement_race:browser/action/advancement_category_validate with storage advancement_race:runtime advancement_category_request
