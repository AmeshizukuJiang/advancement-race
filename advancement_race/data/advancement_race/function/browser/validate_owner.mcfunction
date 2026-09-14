scoreboard players set #browser_owner_match race_state 1
execute unless data storage advancement_race:runtime browser_work.clicker_uuid run scoreboard players set #browser_owner_match race_state 0
execute unless data storage advancement_race:runtime browser_work.session.owner_uuid run scoreboard players set #browser_owner_match race_state 0
execute store result score #browser_clicker_uuid_0 race_state run data get storage advancement_race:runtime browser_work.clicker_uuid[0]
execute store result score #browser_owner_uuid_0 race_state run data get storage advancement_race:runtime browser_work.session.owner_uuid[0]
execute unless score #browser_clicker_uuid_0 race_state = #browser_owner_uuid_0 race_state run scoreboard players set #browser_owner_match race_state 0
execute store result score #browser_clicker_uuid_1 race_state run data get storage advancement_race:runtime browser_work.clicker_uuid[1]
execute store result score #browser_owner_uuid_1 race_state run data get storage advancement_race:runtime browser_work.session.owner_uuid[1]
execute unless score #browser_clicker_uuid_1 race_state = #browser_owner_uuid_1 race_state run scoreboard players set #browser_owner_match race_state 0
execute store result score #browser_clicker_uuid_2 race_state run data get storage advancement_race:runtime browser_work.clicker_uuid[2]
execute store result score #browser_owner_uuid_2 race_state run data get storage advancement_race:runtime browser_work.session.owner_uuid[2]
execute unless score #browser_clicker_uuid_2 race_state = #browser_owner_uuid_2 race_state run scoreboard players set #browser_owner_match race_state 0
execute store result score #browser_clicker_uuid_3 race_state run data get storage advancement_race:runtime browser_work.clicker_uuid[3]
execute store result score #browser_owner_uuid_3 race_state run data get storage advancement_race:runtime browser_work.session.owner_uuid[3]
execute unless score #browser_clicker_uuid_3 race_state = #browser_owner_uuid_3 race_state run scoreboard players set #browser_owner_match race_state 0
execute unless score #browser_owner_match race_state matches 1 run scoreboard players set #browser_valid race_state 0
