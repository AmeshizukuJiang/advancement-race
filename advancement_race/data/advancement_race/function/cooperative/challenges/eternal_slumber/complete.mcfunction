data modify storage advancement_race:match cooperative.challenges.eternal_slumber.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.eternal_slumber.remaining_seconds set value 0
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/eternal_slumber",title:"永恒梦乡"}
function advancement_race:cooperative/challenges/prepare_reward {key:"eternal_slumber"}
