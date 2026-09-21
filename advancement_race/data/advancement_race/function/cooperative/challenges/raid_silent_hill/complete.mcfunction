data modify storage advancement_race:match cooperative.challenges.raid_silent_hill.status set value "completed"
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/raid_silent_hill",title:"Raid Silent Hill"}
function advancement_race:cooperative/challenges/prepare_reward {key:"raid_silent_hill"}
