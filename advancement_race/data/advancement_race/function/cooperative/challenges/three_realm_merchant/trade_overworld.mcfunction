advancement revoke @s only advancement_race_coop:challenge/three_realm_merchant_overworld
data modify storage advancement_race:runtime n15_merchant_trade set value {}
data modify storage advancement_race:runtime n15_merchant_trade.expected_uuid set from storage advancement_race:match cooperative.challenges.three_realm_merchant.villager_uuid
execute at @s as @e[type=minecraft:villager,tag=advancement_race_n15_merchant,distance=..8,limit=1,sort=nearest] run data modify storage advancement_race:runtime n15_merchant_trade.candidate_uuid set from entity @s UUID
execute if data storage advancement_race:runtime n15_merchant_trade.candidate_uuid run function advancement_race:cooperative/challenges/three_realm_merchant/verify_overworld with storage advancement_race:runtime n15_merchant_trade
