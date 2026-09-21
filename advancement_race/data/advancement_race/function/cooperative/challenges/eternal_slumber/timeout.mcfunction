data modify storage advancement_race:match cooperative.challenges.eternal_slumber.status set value "timed_out"
tellraw @a [{"text":"Eternal Slumber timed out.","color":"red","bold":true},{"text":" Open the Info Center to retry.","color":"gray","bold":false}]
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.independent{failure_tax:1b} run function advancement_race:cooperative/modifiers/failure_tax/apply
