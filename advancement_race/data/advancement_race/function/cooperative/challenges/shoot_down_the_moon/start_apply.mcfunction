function advancement_race:cooperative/challenges/shoot_down_the_moon/cleanup_target
data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.status set value "armed"
data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.remaining_ticks set value 0
data modify storage advancement_race:match cooperative.challenges.shoot_down_the_moon.remaining_seconds set value 0
data remove storage advancement_race:match cooperative.challenges.shoot_down_the_moon.dragon_uuid
execute store result score #n15_moon_attempts race_state run data get storage advancement_race:match cooperative.challenges.shoot_down_the_moon.attempts
scoreboard players add #n15_moon_attempts race_state 1
execute store result storage advancement_race:match cooperative.challenges.shoot_down_the_moon.attempts int 1 run scoreboard players get #n15_moon_attempts race_state
execute as @a[scores={race_participant=0..}] run advancement revoke @s only advancement_race_coop:challenge/shoot_down_the_moon_dragon
tellraw @a [{"text":"Shoot Down the Moon armed! ","color":"aqua","bold":true},{"text":"Respawn the Ender Dragon. The team will have 5 seconds from its appearance to kill it.","color":"gray","bold":false}]
