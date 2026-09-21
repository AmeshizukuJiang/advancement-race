advancement revoke @s only advancement_race_coop:challenge/three_realm_merchant_nether
scoreboard players set #n15_merchant_new race_state 0
execute if data storage advancement_race:match {status:"active",mode:"cooperative_border"} if score @s race_participant matches 0.. if data storage advancement_race:match cooperative.challenges.three_realm_merchant{status:"active",nether:0b} run scoreboard players set #n15_merchant_new race_state 1
execute if score #n15_merchant_new race_state matches 1 run data modify storage advancement_race:match cooperative.challenges.three_realm_merchant.nether set value 1b
execute if score #n15_merchant_new race_state matches 1 run tellraw @a [{"text":"Three-Realm Merchant: ","color":"aqua","bold":true},{"text":"Nether trade complete.","color":"green","bold":false}]
execute if score #n15_merchant_new race_state matches 1 run function advancement_race:cooperative/challenges/three_realm_merchant/check
