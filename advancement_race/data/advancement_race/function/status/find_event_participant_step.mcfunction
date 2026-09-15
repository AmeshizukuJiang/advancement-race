$data modify storage advancement_race:runtime status_work.participant set from storage advancement_race:runtime status.participants[$(participant_index)]
data modify storage advancement_race:runtime status_work.participant_uuid set from storage advancement_race:runtime status_work.participant.uuid
function advancement_race:status/apply_event with storage advancement_race:runtime status_work
