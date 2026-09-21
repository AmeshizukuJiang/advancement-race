data modify storage advancement_race:match cooperative.challenges.ecological_restoration.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.ecological_restoration.remaining_seconds set value 0
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/ecological_restoration",title:"Ecological Restoration"}
function advancement_race:cooperative/challenges/prepare_reward {key:"ecological_restoration"}
