$data modify storage advancement_race:runtime cooperative_completion set value {kind:"vanilla_advancement",id:"$(advancement)",title_translate:"$(title)"}
data modify storage advancement_race:runtime cooperative_completion.reward set from storage advancement_race:match rules.cooperative.rewards.vanilla.points
data modify storage advancement_race:runtime cooperative_completion.border_delta set from storage advancement_race:match rules.cooperative.rewards.vanilla.border_delta
function advancement_race:cooperative/completion/apply
