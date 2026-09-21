data modify storage advancement_race:match cooperative.challenges.still_not_fast_enough.remaining_seconds set value 0
data modify storage advancement_race:match cooperative.challenges.still_not_fast_enough.status set value "timed_out"
tag @a remove advancement_race_n9_border_overworld_pending
tag @a remove advancement_race_n9_border_nether_pending
tag @a remove advancement_race_n9_border_end_pending
tellraw @a [{"text":"Still Not Fast Enough failed because every registered participant went offline.","color":"red"}]
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.independent{failure_tax:1b} run function advancement_race:cooperative/modifiers/failure_tax/apply
