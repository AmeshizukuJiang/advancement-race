execute store result score #finale_remaining race_state run data get storage advancement_race:match cooperative.challenges.three_realm_finale.remaining_seconds
scoreboard players remove #finale_remaining race_state 1
execute if score #finale_remaining race_state matches ..0 run scoreboard players set #finale_remaining race_state 0
execute store result storage advancement_race:match cooperative.challenges.three_realm_finale.remaining_seconds int 1 run scoreboard players get #finale_remaining race_state
execute if score #finale_remaining race_state matches 0 run function advancement_race:cooperative/challenges/three_realm_finale/timeout
