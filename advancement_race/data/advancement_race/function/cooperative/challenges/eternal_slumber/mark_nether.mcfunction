execute if data storage advancement_race:match cooperative.challenges.eternal_slumber{status:"active",nether:0b} run data modify storage advancement_race:match cooperative.challenges.eternal_slumber.nether set value 1b
tellraw @a [{"text":"Eternal Slumber: ","color":"aqua","bold":true},{"text":"Nether bed death complete.","color":"green","bold":false}]
function advancement_race:cooperative/challenges/eternal_slumber/check
