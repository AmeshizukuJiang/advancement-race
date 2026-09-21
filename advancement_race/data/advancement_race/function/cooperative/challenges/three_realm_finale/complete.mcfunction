data modify storage advancement_race:match cooperative.challenges.three_realm_finale.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.three_realm_finale.remaining_seconds set value 0
function advancement_race:cooperative/challenges/three_realm_finale/cleanup_targets
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/three_realm_finale",title:"Three-Realm Finale"}
function advancement_race:cooperative/challenges/prepare_reward {key:"three_realm_finale"}
