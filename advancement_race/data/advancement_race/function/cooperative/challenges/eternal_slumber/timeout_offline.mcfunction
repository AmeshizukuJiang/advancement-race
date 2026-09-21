data modify storage advancement_race:match cooperative.challenges.eternal_slumber.status set value "timed_out"
data modify storage advancement_race:match cooperative.challenges.eternal_slumber.remaining_seconds set value 0
tellraw @a [{"text":"Eternal Slumber failed because every registered participant went offline.","color":"red","bold":true}]
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.independent{failure_tax:1b} run function advancement_race:cooperative/modifiers/failure_tax/apply
