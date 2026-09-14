scoreboard players set #admin_expected_active race_state 0
execute if data storage advancement_race:match {status:"active"} run scoreboard players set #admin_expected_active race_state 1
execute if score #admin_expected_active race_state = #match_active race_state run tellraw @s [{"text":"PASS match.status agrees with #match_active"}]
execute unless score #admin_expected_active race_state = #match_active race_state run tellraw @s [{"text":"FAIL match.status disagrees with #match_active"}]
