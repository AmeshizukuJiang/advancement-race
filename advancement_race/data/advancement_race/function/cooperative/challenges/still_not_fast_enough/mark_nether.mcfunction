data modify storage advancement_race:match cooperative.challenges.still_not_fast_enough.nether set value 1b
tellraw @a [{"text":"Still Not Fast Enough: ","color":"aqua","bold":true},{"text":"Nether Border death complete.","color":"green","bold":false}]
function advancement_race:cooperative/challenges/still_not_fast_enough/check
