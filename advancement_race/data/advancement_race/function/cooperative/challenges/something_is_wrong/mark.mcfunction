$data modify storage advancement_race:match cooperative.challenges.something_is_wrong.$(field) set value 1b
$tellraw @a [{"text":"Something Is Wrong: ","color":"aqua","bold":true},{"selector":"@s","color":"white","bold":false},{"text":" completed $(label).","color":"green"}]
function advancement_race:cooperative/challenges/something_is_wrong/check
