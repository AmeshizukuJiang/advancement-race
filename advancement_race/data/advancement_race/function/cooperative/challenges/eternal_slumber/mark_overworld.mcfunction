execute if data storage advancement_race:match cooperative.challenges.eternal_slumber{status:"active",overworld:0b} run data modify storage advancement_race:match cooperative.challenges.eternal_slumber.overworld set value 1b
tellraw @a [{"text":"Eternal Slumber: ","color":"aqua","bold":true},{"text":"Overworld respawn-anchor death complete.","color":"green","bold":false}]
function advancement_race:cooperative/challenges/eternal_slumber/check
