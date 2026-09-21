data modify storage advancement_race:match cooperative.challenges.foreign_crusade.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.foreign_crusade.remaining_seconds set value 0
function advancement_race:cooperative/challenges/foreign_crusade/cleanup_targets
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/foreign_crusade",title:"Foreign Crusade"}
function advancement_race:cooperative/challenges/prepare_reward {key:"foreign_crusade"}
