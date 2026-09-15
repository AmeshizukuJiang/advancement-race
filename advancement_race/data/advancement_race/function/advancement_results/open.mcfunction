data modify storage advancement_race:runtime advancement_results set value {status:"building",events:[],pages:[]}
data modify storage advancement_race:runtime advancement_results.source set from storage advancement_race:runtime advancement_results_request.source
data modify storage advancement_race:runtime advancement_results.mode set from storage advancement_race:runtime advancement_results_source.mode
data modify storage advancement_race:runtime advancement_results.match_id set from storage advancement_race:runtime advancement_results_source.match_id
data modify storage advancement_race:runtime advancement_results.advancement set from storage advancement_race:runtime advancement_results_request.advancement
data modify storage advancement_race:runtime advancement_results.title_translate set from storage advancement_race:runtime advancement_results_request.title_translate
execute unless data storage advancement_race:runtime advancement_results.advancement run tellraw @s [{"text":"This advancement is no longer available.","color":"red"}]
execute unless data storage advancement_race:runtime advancement_results.title_translate run tellraw @s [{"text":"This advancement title is no longer available.","color":"red"}]
execute if data storage advancement_race:runtime advancement_results.advancement if data storage advancement_race:runtime advancement_results.title_translate run function advancement_race:advancement_results/prepare
