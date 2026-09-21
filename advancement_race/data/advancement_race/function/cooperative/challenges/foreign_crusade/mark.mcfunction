$data modify storage advancement_race:match cooperative.challenges.foreign_crusade.$(field) set value 1b
$tellraw @a [{"text":"Foreign Crusade: ","color":"aqua","bold":true},{"text":"$(label) defeated.","color":"green","bold":false}]
function advancement_race:cooperative/challenges/foreign_crusade/check
