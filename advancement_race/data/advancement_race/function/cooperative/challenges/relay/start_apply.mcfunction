data modify storage advancement_race:match cooperative.challenges.relay.status set value "active"
data modify storage advancement_race:match cooperative.challenges.relay.remaining_seconds set value 300
data modify storage advancement_race:match cooperative.challenges.relay.zombie set value 0b
data modify storage advancement_race:match cooperative.challenges.relay.skeleton set value 0b
data modify storage advancement_race:match cooperative.challenges.relay.creeper set value 0b
data modify storage advancement_race:match cooperative.challenges.relay.spider set value 0b
data modify storage advancement_race:match cooperative.challenges.relay.witch set value 0b
data modify storage advancement_race:match cooperative.challenges.relay.enderman set value 0b
execute store result score #relay_attempts race_state run data get storage advancement_race:match cooperative.challenges.relay.attempts
scoreboard players add #relay_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.relay.attempts int 1 run scoreboard players get #relay_attempts race_state
tellraw @a [{"text":"Calamity Relay started! ","color":"aqua","bold":true},{"text":"Kill a Zombie, Skeleton, Creeper, Spider, Witch, and Enderman within 5 minutes.","color":"gray","bold":false}]
