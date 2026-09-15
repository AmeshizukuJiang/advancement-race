data modify storage advancement_race:runtime advancement_category_book set value {status:"building",pages:[]}
data modify storage advancement_race:runtime advancement_category_book.source set from storage advancement_race:runtime advancement_category_request.source
data modify storage advancement_race:runtime advancement_category_book.category set from storage advancement_race:runtime advancement_category_request.category
data modify storage advancement_race:runtime advancement_category_book.category_title set from storage advancement_race:runtime advancement_category_request.category_title
data modify storage advancement_race:runtime advancement_category_book.category_count set from storage advancement_race:runtime advancement_category_request.category_count
data modify storage advancement_race:runtime advancement_category_book.match_id set from storage advancement_race:runtime advancement_category_request.match_id
data modify storage advancement_race:runtime browser_request set value {view:"advancement_category",source:{kind:"live"}}
execute if data storage advancement_race:runtime advancement_category_book.source{kind:"history"} run data modify storage advancement_race:runtime browser_request set value {view:"advancement_category",source:{kind:"history"}}
data modify storage advancement_race:runtime browser_request.source.match_id set from storage advancement_race:runtime advancement_category_book.match_id
data modify storage advancement_race:runtime browser_request.category set from storage advancement_race:runtime advancement_category_book.category
function advancement_race:browser/session/begin
data modify storage advancement_race:runtime advancement_category_work set value {entry:{},page_number:1}
data modify storage advancement_race:runtime advancement_category_work.category_title set from storage advancement_race:runtime advancement_category_book.category_title
data modify storage advancement_race:runtime advancement_category_work.category_count set from storage advancement_race:runtime advancement_category_book.category_count
scoreboard players set #advancement_category_entries_on_page race_state 0
scoreboard players set #advancement_category_page_number race_state 1
function advancement_race:advancement_category_book/append_page with storage advancement_race:runtime advancement_category_work
execute if data storage advancement_race:runtime advancement_category_book{category:"story"} run function advancement_race:presentation/advancement_index/story
execute if data storage advancement_race:runtime advancement_category_book{category:"nether"} run function advancement_race:presentation/advancement_index/nether
execute if data storage advancement_race:runtime advancement_category_book{category:"end"} run function advancement_race:presentation/advancement_index/end
execute if data storage advancement_race:runtime advancement_category_book{category:"adventure"} run function advancement_race:presentation/advancement_index/adventure
execute if data storage advancement_race:runtime advancement_category_book{category:"husbandry"} run function advancement_race:presentation/advancement_index/husbandry
data modify storage advancement_race:runtime advancement_category_book.status set value "ready"
function advancement_race:browser/session/finalize
function advancement_race:advancement_category_book/give_item with storage advancement_race:runtime advancement_category_book
