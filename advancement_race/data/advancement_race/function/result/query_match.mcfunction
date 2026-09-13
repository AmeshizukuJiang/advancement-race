$data modify storage advancement_race:runtime result_request.match_id set value $(match_id)
$data modify storage advancement_race:runtime result_request.advancement set value "$(advancement)"
function advancement_race:result/calculate
function advancement_race:result/query_from_request
