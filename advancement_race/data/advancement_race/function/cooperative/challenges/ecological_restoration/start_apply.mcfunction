data modify storage advancement_race:match cooperative.challenges.ecological_restoration.status set value "active"
data modify storage advancement_race:match cooperative.challenges.ecological_restoration.remaining_seconds set value 180
data modify storage advancement_race:match cooperative.challenges.ecological_restoration.wheat set value 0b
data modify storage advancement_race:match cooperative.challenges.ecological_restoration.beetroot set value 0b
data modify storage advancement_race:match cooperative.challenges.ecological_restoration.carrot set value 0b
data modify storage advancement_race:match cooperative.challenges.ecological_restoration.potato set value 0b
data modify storage advancement_race:match cooperative.challenges.ecological_restoration.pumpkin set value 0b
data modify storage advancement_race:match cooperative.challenges.ecological_restoration.melon set value 0b
data modify storage advancement_race:match cooperative.challenges.ecological_restoration.torchflower set value 0b
data modify storage advancement_race:match cooperative.challenges.ecological_restoration.pitcher set value 0b
data modify storage advancement_race:match cooperative.challenges.ecological_restoration.cocoa set value 0b
data modify storage advancement_race:match cooperative.challenges.ecological_restoration.nether_wart set value 0b
execute store result score #eco_attempts race_state run data get storage advancement_race:match cooperative.challenges.ecological_restoration.attempts
scoreboard players add #eco_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.ecological_restoration.attempts int 1 run scoreboard players get #eco_attempts race_state
execute as @a[scores={race_participant=0..}] run function advancement_race:cooperative/challenges/ecological_restoration/revoke_helpers
tellraw @a [{"text":"Ecological Restoration started! ","color":"aqua","bold":true},{"text":"Plant all ten required crops within 3 minutes.","color":"gray","bold":false}]
