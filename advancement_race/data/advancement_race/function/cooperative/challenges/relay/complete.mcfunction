data modify storage advancement_race:match cooperative.challenges.relay.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.relay.remaining_seconds set value 0
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/calamity_relay",title:"Calamity Relay"}
function advancement_race:cooperative/challenges/prepare_reward {key:"calamity_relay"}
