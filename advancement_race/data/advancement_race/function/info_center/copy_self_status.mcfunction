$data modify storage advancement_race:runtime info_center.self set from storage advancement_race:runtime status.participants[$(participant_index)]
data modify storage advancement_race:runtime info_center.self_name set from storage advancement_race:runtime info_center.self.name
data modify storage advancement_race:runtime info_center.self_points set from storage advancement_race:runtime info_center.self.points
data modify storage advancement_race:runtime info_center.self_rank set from storage advancement_race:runtime info_center.self.rank
data modify storage advancement_race:runtime info_center.self_completed set from storage advancement_race:runtime info_center.self.completed
