data modify storage advancement_race:match cooperative.challenges.still_not_fast_enough.status set value "active"
data modify storage advancement_race:match cooperative.challenges.still_not_fast_enough.remaining_seconds set value 900
data modify storage advancement_race:match cooperative.challenges.still_not_fast_enough.overworld set value 0b
data modify storage advancement_race:match cooperative.challenges.still_not_fast_enough.nether set value 0b
data modify storage advancement_race:match cooperative.challenges.still_not_fast_enough.end set value 0b
data modify storage advancement_race:match cooperative.challenges.still_not_fast_enough.owner_uuid set from entity @s UUID
execute store result score #still_attempts race_state run data get storage advancement_race:match cooperative.challenges.still_not_fast_enough.attempts
scoreboard players add #still_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.still_not_fast_enough.attempts int 1 run scoreboard players get #still_attempts race_state
advancement revoke @a[scores={race_participant=0..}] only advancement_race_coop:challenge/still_not_fast_enough
tag @a remove advancement_race_n9_border_overworld_pending
tag @a remove advancement_race_n9_border_nether_pending
tag @a remove advancement_race_n9_border_end_pending
execute as @a[scores={race_participant=0..}] run scoreboard players operation @s race_challenge_death_seen = @s race_deaths
tellraw @a [{"text":"Still Not Fast Enough started! ","color":"aqua","bold":true},{"selector":"@s","color":"white","bold":false},{"text":" must die to the World Border in all three dimensions within 15 minutes.","color":"gray","bold":false}]
