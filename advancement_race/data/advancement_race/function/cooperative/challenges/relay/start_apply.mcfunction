data modify storage advancement_race:match cooperative.challenges.relay.status set value "active"
data modify storage advancement_race:match cooperative.challenges.relay.remaining_seconds set from storage advancement_race:match rules.cooperative.relay.duration_seconds
data modify storage advancement_race:match cooperative.challenges.relay.zombie set value 0b
data modify storage advancement_race:match cooperative.challenges.relay.skeleton set value 0b
data modify storage advancement_race:match cooperative.challenges.relay.creeper set value 0b
execute store result score #relay_attempts race_state run data get storage advancement_race:match cooperative.challenges.relay.attempts
scoreboard players add #relay_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.relay.attempts int 1 run scoreboard players get #relay_attempts race_state
tellraw @a [{"text":"Calamity Relay started! ","color":"aqua","bold":true},{"text":"The team must kill a Zombie, Skeleton, and Creeper before time expires.","color":"gray","bold":false}]
