$data modify storage advancement_race:match cooperative.challenges.ecological_restoration.$(field) set value 1b
$tellraw @a [{"text":"Ecological Restoration: ","color":"aqua","bold":true},{"selector":"@s","color":"white","bold":false},{"text":" planted $(label).","color":"green"}]
function advancement_race:cooperative/challenges/ecological_restoration/check
