data modify storage advancement_race:match cooperative.challenges.still_not_fast_enough.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.still_not_fast_enough.remaining_seconds set value 0
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/still_not_fast_enough",title:"Still Not Fast Enough"}
function advancement_race:cooperative/challenges/prepare_reward {key:"still_not_fast_enough"}
