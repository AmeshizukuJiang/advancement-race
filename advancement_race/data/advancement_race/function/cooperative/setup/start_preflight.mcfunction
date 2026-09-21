function advancement_race:cooperative/setup/ensure_defaults
scoreboard players set #coop_config_valid race_state 0
execute if data storage advancement_race:config cooperative_v11{schema_version:1} if data storage advancement_race:config cooperative_v11.difficulty_profiles[18] if data storage advancement_race:config cooperative_v11.vanilla_rewards[120] if data storage advancement_race:config cooperative_v11.custom_challenges[28] run function advancement_race:cooperative/setup/validate_selected_level with storage advancement_race:match setup.cooperative
execute if score #coop_config_valid race_state matches 1 run function advancement_race:match/start_apply
execute unless score #coop_config_valid race_state matches 1 run tellraw @s [{"text":"Cannot start Cooperative Border: the v1.1 configuration did not load completely. Run /reload and check the server log.","color":"red"}]
