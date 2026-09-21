data modify storage advancement_race:match cooperative.challenges.still_not_fast_enough.overworld set value 1b
tellraw @a [{"text":"Still Not Fast Enough: ","color":"aqua","bold":true},{"text":"Overworld Border death complete.","color":"green","bold":false}]
function advancement_race:cooperative/challenges/still_not_fast_enough/check
