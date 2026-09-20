$data modify storage advancement_race:match cooperative.challenges.relay.$(field) set value 1b
$tellraw @a [{"text":"Calamity Relay: ","color":"aqua","bold":true},{"selector":"@s","color":"white","bold":false},{"text":" completed $(label).","color":"green"}]
function advancement_race:cooperative/challenges/relay/check
