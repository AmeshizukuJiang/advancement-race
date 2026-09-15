$data modify storage advancement_race:runtime info_center_standings_work.candidate set from storage advancement_race:runtime info_center.standings_participants[$(participant_index)]
execute store result score #info_center_standings_candidate_rank race_state run data get storage advancement_race:runtime info_center_standings_work.candidate.rank
execute if score #info_center_standings_candidate_rank race_state = #info_center_standings_rank race_state run function advancement_race:info_center/standings/append_entry
