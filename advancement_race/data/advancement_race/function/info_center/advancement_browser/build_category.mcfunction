execute store result score #info_center_page_count race_state run data get storage advancement_race:runtime info_center.pages
scoreboard players add #info_center_page_count race_state 1
execute store result storage advancement_race:runtime info_center_work.category_start_page int 1 run scoreboard players get #info_center_page_count race_state
scoreboard players set #info_center_category_own race_state 0
scoreboard players set #info_center_category_entries race_state 0
scoreboard players set #info_center_category_page race_state 1
data modify storage advancement_race:runtime info_center_work.category_page set value 1
function advancement_race:info_center/advancement_browser/append_page with storage advancement_race:runtime info_center_work
execute if data storage advancement_race:runtime info_center_work{category:"story"} run function advancement_race:presentation/info_center_advancements/story with storage advancement_race:runtime info_center
execute if data storage advancement_race:runtime info_center_work{category:"nether"} run function advancement_race:presentation/info_center_advancements/nether with storage advancement_race:runtime info_center
execute if data storage advancement_race:runtime info_center_work{category:"end"} run function advancement_race:presentation/info_center_advancements/end with storage advancement_race:runtime info_center
execute if data storage advancement_race:runtime info_center_work{category:"adventure"} run function advancement_race:presentation/info_center_advancements/adventure with storage advancement_race:runtime info_center
execute if data storage advancement_race:runtime info_center_work{category:"husbandry"} run function advancement_race:presentation/info_center_advancements/husbandry with storage advancement_race:runtime info_center
execute if data storage advancement_race:runtime info_center_work{category:"story"} run function advancement_race:info_center/advancement_browser/store_story
execute if data storage advancement_race:runtime info_center_work{category:"nether"} run function advancement_race:info_center/advancement_browser/store_nether
execute if data storage advancement_race:runtime info_center_work{category:"end"} run function advancement_race:info_center/advancement_browser/store_end
execute if data storage advancement_race:runtime info_center_work{category:"adventure"} run function advancement_race:info_center/advancement_browser/store_adventure
execute if data storage advancement_race:runtime info_center_work{category:"husbandry"} run function advancement_race:info_center/advancement_browser/store_husbandry
