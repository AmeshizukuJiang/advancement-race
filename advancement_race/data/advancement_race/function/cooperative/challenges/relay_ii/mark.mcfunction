$data modify storage advancement_race:match cooperative.challenges.relay_ii.$(field) set value 1b
$tellraw @a [{"text":"Calamity Relay II: ","color":"aqua","bold":true},{"selector":"@s","color":"white","bold":false},{"text":" completed $(label).","color":"green"}]
function advancement_race:cooperative/challenges/relay_ii/check
