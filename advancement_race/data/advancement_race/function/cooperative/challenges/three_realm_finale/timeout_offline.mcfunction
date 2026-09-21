data modify storage advancement_race:match cooperative.challenges.three_realm_finale.remaining_seconds set value 0
data modify storage advancement_race:match cooperative.challenges.three_realm_finale.status set value "timed_out"
function advancement_race:cooperative/challenges/three_realm_finale/cleanup_targets
tellraw @a [{"text":"Three-Realm Finale failed because every registered participant went offline.","color":"red"}]
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.independent{failure_tax:1b} run function advancement_race:cooperative/modifiers/failure_tax/apply
