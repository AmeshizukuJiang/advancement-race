data modify storage advancement_race:match cooperative.challenges.supply.status set value "completed"
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/four_realm_supply_line",title:"Four-Realm Supply Line"}
data modify storage advancement_race:runtime cooperative_completion.reward set from storage advancement_race:match rules.cooperative.rewards.supply.points
data modify storage advancement_race:runtime cooperative_completion.border_delta set from storage advancement_race:match rules.cooperative.rewards.supply.border_delta
function advancement_race:cooperative/completion/apply
