data modify storage advancement_race:match cooperative.challenges.museum_closing_check.status set value "completed"
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/museum_closing_check",title:"Museum Closing Check"}
function advancement_race:cooperative/challenges/prepare_reward {key:"museum_closing_check"}
