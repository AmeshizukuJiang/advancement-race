data modify storage advancement_race:match cooperative.challenges.end_fishing.status set value "completed"
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/end_fishing",title:"末地垂钓"}
function advancement_race:cooperative/challenges/prepare_reward {key:"end_fishing"}
