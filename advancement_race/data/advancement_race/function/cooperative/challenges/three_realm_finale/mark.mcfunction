$data modify storage advancement_race:match cooperative.challenges.three_realm_finale.$(field) set value 1b
$tellraw @a [{"text":"Three-Realm Finale: ","color":"aqua","bold":true},{"text":"$(label) defeated.","color":"green","bold":false}]
function advancement_race:cooperative/challenges/three_realm_finale/check
