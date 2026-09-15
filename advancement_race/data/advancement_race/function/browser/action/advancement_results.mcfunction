data modify storage advancement_race:runtime advancement_results_request set value {}
data modify storage advancement_race:runtime advancement_results_request.source set from storage advancement_race:runtime browser_work.session.source
data modify storage advancement_race:runtime advancement_results_request.advancement set from storage advancement_race:runtime browser_work.action.advancement
data modify storage advancement_race:runtime advancement_results_request.title_translate set from storage advancement_race:runtime browser_work.action.title_translate
execute if data storage advancement_race:runtime browser_work.session.source.match_id run data modify storage advancement_race:runtime advancement_results_request.match_id set from storage advancement_race:runtime browser_work.session.source.match_id
execute if data storage advancement_race:runtime browser_work{session:{view:"advancement_category",source:{kind:"live"}},action:{kind:"advancement_results"}} run scoreboard players set #browser_dispatched race_state 1
execute if data storage advancement_race:runtime browser_work{session:{view:"advancement_category",source:{kind:"live"}},action:{kind:"advancement_results"}} run function advancement_race:advancement_results/open_live
execute if data storage advancement_race:runtime browser_work{session:{view:"advancement_category",source:{kind:"history"}},action:{kind:"advancement_results"}} run function advancement_race:browser/action/advancement_results_validate with storage advancement_race:runtime advancement_results_request
