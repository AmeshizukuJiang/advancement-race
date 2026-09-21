data modify storage advancement_race:match cooperative.challenges.flowers_beyond.status set value "timed_out"
data modify storage advancement_race:match cooperative.challenges.flowers_beyond.remaining_seconds set value 0
tellraw @a [{"text":"Flowers Beyond timed out.","color":"red","bold":true},{"text":" Open the Info Center to retry from zero.","color":"gray","bold":false}]
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.independent{failure_tax:1b} run function advancement_race:cooperative/modifiers/failure_tax/apply
