data modify storage advancement_race:runtime browser_request set value {view:"info_center_history",source:{kind:"history_list"},page:0}
data modify storage advancement_race:runtime browser_request.page set from storage advancement_race:runtime browser_work.action.page
function advancement_race:info_center/history/open_page
