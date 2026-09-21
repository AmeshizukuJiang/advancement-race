data modify storage advancement_race:match cooperative.challenges.flowers_beyond.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.flowers_beyond.remaining_seconds set value 0
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/flowers_beyond",title:"Flowers Beyond"}
function advancement_race:cooperative/challenges/prepare_reward {key:"flowers_beyond"}
