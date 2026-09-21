data modify storage advancement_race:match cooperative.challenges.jailer_unemployed.status set value "completed"
function advancement_race:cooperative/challenges/jailer_unemployed/cleanup_targets
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/jailer_unemployed",title:"Jailer Unemployed"}
function advancement_race:cooperative/challenges/prepare_reward {key:"jailer_unemployed"}
