data modify storage advancement_race:match cooperative.challenges.foreign_crusade.remaining_seconds set value 0
data modify storage advancement_race:match cooperative.challenges.foreign_crusade.status set value "timed_out"
function advancement_race:cooperative/challenges/foreign_crusade/cleanup_targets
tellraw @a [{"text":"Foreign Crusade failed because every registered participant went offline.","color":"red"}]
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.independent{failure_tax:1b} run function advancement_race:cooperative/modifiers/failure_tax/apply
