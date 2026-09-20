data modify storage advancement_race:match cooperative.challenges.relay.status set value "timed_out"
tellraw @a [{"text":"Calamity Relay timed out.","color":"red","bold":true},{"text":" Open the Info Center to retry.","color":"gray","bold":false}]
