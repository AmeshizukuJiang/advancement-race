data modify storage advancement_race:match cooperative.challenges.three_realm_finale.status set value "timed_out"
function advancement_race:cooperative/challenges/three_realm_finale/cleanup_targets
tellraw @a [{"text":"Three-Realm Finale timed out.","color":"red","bold":true},{"text":" Open the Info Center to bind new targets and retry.","color":"gray","bold":false}]
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.independent{failure_tax:1b} run function advancement_race:cooperative/modifiers/failure_tax/apply
