data modify storage advancement_race:match cooperative.challenges.something_is_wrong.status set value "active"
data modify storage advancement_race:match cooperative.challenges.something_is_wrong.remaining_seconds set value 300
data modify storage advancement_race:match cooperative.challenges.something_is_wrong.fortress_barter set value 0b
data modify storage advancement_race:match cooperative.challenges.something_is_wrong.bastion_blaze set value 0b
execute store result score #wrong_attempts race_state run data get storage advancement_race:match cooperative.challenges.something_is_wrong.attempts
scoreboard players add #wrong_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.something_is_wrong.attempts int 1 run scoreboard players get #wrong_attempts race_state
execute as @a[scores={race_participant=0..}] run function advancement_race:cooperative/challenges/something_is_wrong/revoke_helpers
tellraw @a [{"text":"Something Is Wrong started! ","color":"aqua","bold":true},{"text":"Within 5 minutes: barter with a Piglin in a Fortress and kill a Blaze in a Bastion.","color":"gray","bold":false}]
