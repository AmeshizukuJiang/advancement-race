data modify storage advancement_race:match cooperative.challenges.rekindle_old_dream.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.rekindle_old_dream.window_ticks set value 0
function advancement_race:cooperative/challenges/rekindle_old_dream/cleanup
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/rekindle_old_dream",title:"Rekindle an Old Dream"}
function advancement_race:cooperative/challenges/prepare_reward {key:"rekindle_old_dream"}
