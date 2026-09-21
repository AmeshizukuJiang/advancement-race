data modify storage advancement_race:match cooperative.challenges.something_is_wrong.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.something_is_wrong.remaining_seconds set value 0
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/something_is_wrong",title:"Something Is Wrong"}
function advancement_race:cooperative/challenges/prepare_reward {key:"something_is_wrong"}
