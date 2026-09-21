data modify storage advancement_race:match cooperative.challenges.three_realm_merchant.status set value "completed"
function advancement_race:cooperative/challenges/three_realm_merchant/cleanup_target
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/three_realm_merchant",title:"Three-Realm Merchant"}
function advancement_race:cooperative/challenges/prepare_reward {key:"three_realm_merchant"}
