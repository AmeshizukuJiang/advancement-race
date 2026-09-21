data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.status set value "timed_out"
data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.remaining_ticks set value 0
data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.remaining_seconds set value 0
function advancement_race:cooperative/challenges/shoot_down_the_moon/cleanup_target
tellraw @a [{"text":"Shoot Down the Moon failed. ","color":"red","bold":true},{"text":"The bound dragon disappeared without a registered participant receiving the kill.","color":"gray","bold":false}]
execute if data storage advancement_race:match rules.cooperative.v11.modifiers.independent{failure_tax:1b} run function advancement_race:cooperative/modifiers/failure_tax/apply
