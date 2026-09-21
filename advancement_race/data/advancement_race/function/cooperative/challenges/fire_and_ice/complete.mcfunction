data modify storage advancement_race:match cooperative.challenges.fire_and_ice.status set value "completed"
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/fire_and_ice",title:"冰火两重天"}
function advancement_race:cooperative/challenges/prepare_reward {key:"fire_and_ice"}
