data modify storage advancement_race:runtime advancement_index_book set value {status:"building",pages:[]}
data modify storage advancement_race:runtime advancement_index_book.mode set from storage advancement_race:runtime advancement_index.mode
data modify storage advancement_race:runtime advancement_index_book.mode_label set value "Live"
execute if data storage advancement_race:runtime advancement_index{mode:"final"} run data modify storage advancement_race:runtime advancement_index_book.mode_label set value "Final"
data modify storage advancement_race:runtime advancement_index_book.match_id set from storage advancement_race:runtime advancement_index.match_id
data modify storage advancement_race:runtime browser_request set value {view:"advancement_index",source:{kind:"live"}}
execute if data storage advancement_race:runtime advancement_index{mode:"final"} run data modify storage advancement_race:runtime browser_request set value {view:"advancement_index",source:{kind:"history"}}
data modify storage advancement_race:runtime browser_request.source.match_id set from storage advancement_race:runtime advancement_index.match_id
function advancement_race:browser/session/begin
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"advancement_category",category:"story",category_title:"Story",category_count:15}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime advancement_index_book.story_action_code set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"advancement_category",category:"nether",category_title:"Nether",category_count:22}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime advancement_index_book.nether_action_code set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"advancement_category",category:"end",category_title:"End",category_count:8}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime advancement_index_book.end_action_code set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"advancement_category",category:"adventure",category_title:"Adventure",category_count:46}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime advancement_index_book.adventure_action_code set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"advancement_category",category:"husbandry",category_title:"Husbandry",category_count:30}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime advancement_index_book.husbandry_action_code set from storage advancement_race:runtime browser_work.action_code
function advancement_race:advancement_index_book/build_page with storage advancement_race:runtime advancement_index_book
data modify storage advancement_race:runtime advancement_index_book.status set value "ready"
function advancement_race:browser/session/finalize
function advancement_race:advancement_index_book/give_item with storage advancement_race:runtime advancement_index_book
