$data modify storage advancement_race:runtime result_work.participant set from storage advancement_race:runtime result.participants[$(participant_index)]
data modify storage advancement_race:runtime result_work.participant_name set from storage advancement_race:runtime result_work.participant.name
function advancement_race:result/apply_event with storage advancement_race:runtime result_work
