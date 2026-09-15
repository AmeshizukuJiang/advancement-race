data modify storage advancement_race:runtime advancement_results_source set value {status:"ready",mode:"final",participants:[],events:[]}
data modify storage advancement_race:runtime advancement_results_source.match_id set from storage advancement_race:runtime result.match_id
data modify storage advancement_race:runtime advancement_results_source.participants set from storage advancement_race:runtime result.participants
data modify storage advancement_race:runtime advancement_results_source.events set from storage advancement_race:runtime result.events
