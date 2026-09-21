data modify storage advancement_race:match cooperative.challenges.eternal_slumber.status set value "active"
data modify storage advancement_race:match cooperative.challenges.eternal_slumber.remaining_seconds set value 600
data modify storage advancement_race:match cooperative.challenges.eternal_slumber.overworld set value 0b
data modify storage advancement_race:match cooperative.challenges.eternal_slumber.nether set value 0b
data modify storage advancement_race:match cooperative.challenges.eternal_slumber.end set value 0b
execute as @a[scores={race_participant=0..}] run function advancement_race:cooperative/challenges/eternal_slumber/revoke_helpers
execute store result score #eternal_attempts race_state run data get storage advancement_race:match cooperative.challenges.eternal_slumber.attempts
scoreboard players add #eternal_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.eternal_slumber.attempts int 1 run scoreboard players get #eternal_attempts race_state
tellraw @a [{"text":"Eternal Slumber started! ","color":"aqua","bold":true},{"text":"Within 10 minutes, die to a respawn anchor in the Overworld and beds in the Nether and End.","color":"gray","bold":false}]
