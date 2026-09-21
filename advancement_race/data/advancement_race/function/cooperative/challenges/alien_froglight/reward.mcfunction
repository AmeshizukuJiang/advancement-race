data modify storage advancement_race:match cooperative.challenges.alien_froglight.rewarded set value 1b
data modify storage advancement_race:runtime cooperative_completion set value {kind:"challenge",id:"advancement_race:challenge/alien_froglight",title:"Alien Froglight"}
function advancement_race:cooperative/challenges/prepare_reward {key:"alien_froglight"}
