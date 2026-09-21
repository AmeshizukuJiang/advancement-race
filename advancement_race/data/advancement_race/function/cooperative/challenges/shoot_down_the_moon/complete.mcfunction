data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.remaining_ticks set value 0
data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.remaining_seconds set value 0
function advancement_race:cooperative/challenges/shoot_down_the_moon/cleanup_target
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/shoot_down_the_moon",title:"Shoot Down the Moon"}
function advancement_race:cooperative/challenges/prepare_reward {key:"shoot_down_the_moon"}
