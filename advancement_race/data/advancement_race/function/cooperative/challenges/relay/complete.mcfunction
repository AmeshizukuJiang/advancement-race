data modify storage advancement_race:match cooperative.challenges.relay.status set value "completed"
data modify storage advancement_race:match cooperative.challenges.relay.remaining_seconds set value 0
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/calamity_relay",title:"Calamity Relay"}
data modify storage advancement_race:runtime cooperative_completion.reward set from storage advancement_race:match rules.cooperative.rewards.relay.points
data modify storage advancement_race:runtime cooperative_completion.border_delta set from storage advancement_race:match rules.cooperative.rewards.relay.border_delta
function advancement_race:cooperative/completion/apply
