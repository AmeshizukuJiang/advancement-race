data modify storage advancement_race:match cooperative.challenges.sleep_above_clouds.status set value "completed"
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/sleep_above_clouds",title:"Sleep Above the Clouds"}
function advancement_race:cooperative/challenges/prepare_reward {key:"sleep_above_clouds"}
