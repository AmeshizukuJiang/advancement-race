data modify storage advancement_race:match cooperative.challenges.end_trading_post.status set value "completed"
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/end_trading_post",title:"End Trading Post"}
function advancement_race:cooperative/challenges/prepare_reward {key:"end_trading_post"}
