execute if data storage advancement_race:history {matches:[{status:"ended"}]} run tellraw @s [{"text":"PASS history contains an ended-match archive"}]
execute unless data storage advancement_race:history {matches:[{status:"ended"}]} run tellraw @s [{"text":"WARN history contains no ended-match archive yet"}]
