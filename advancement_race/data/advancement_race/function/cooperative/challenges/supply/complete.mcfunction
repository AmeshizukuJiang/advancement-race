data modify storage advancement_race:match cooperative.challenges.supply.status set value "completed"
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/four_realm_supply_line",title:"Four-Realm Supply Line"}
function advancement_race:cooperative/challenges/prepare_reward {key:"four_realm_supply_line"}
