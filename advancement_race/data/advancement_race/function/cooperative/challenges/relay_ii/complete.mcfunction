data modify storage advancement_race:match cooperative.challenges.relay_ii.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.relay_ii.remaining_seconds set value 0
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/calamity_relay_ii",title:"Calamity Relay II"}
function advancement_race:cooperative/challenges/prepare_reward {key:"calamity_relay_ii"}
