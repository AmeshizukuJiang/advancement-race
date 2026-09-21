function advancement_race:cooperative/ui/prepare_active
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_supply_iron"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.supply_iron_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_supply_gold"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.supply_gold_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_supply_diamond"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.supply_diamond_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_supply_obsidian"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.supply_obsidian_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_relay_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.relay_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_eternal_slumber_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.eternal_slumber_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_ecological_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.ecological_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_something_wrong_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.something_wrong_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_relay_ii_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.relay_ii_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_automation_iron"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.automation_iron_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_automation_dried_kelp"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.automation_dried_kelp_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_automation_fireworks"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.automation_fireworks_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_automation_honey"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.automation_honey_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_three_realm_finale_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.three_realm_finale_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_museum_check"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.museum_check_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_still_not_fast_enough_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.still_not_fast_enough_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_three_realm_merchant_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.three_realm_merchant_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_shoot_down_the_moon_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.shoot_down_the_moon_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_flowers_beyond_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.flowers_beyond_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_jailer_unemployed_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.jailer_unemployed_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_rekindle_old_dream_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.rekindle_old_dream_action set from storage advancement_race:runtime browser_work.action_code
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"coop_foreign_crusade_start"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.foreign_crusade_action set from storage advancement_race:runtime browser_work.action_code
function advancement_race:menu/prepare_vote_progress
execute store result storage advancement_race:runtime info_center.vote_count int 1 run scoreboard players get #menu_vote_count race_state
execute store result storage advancement_race:runtime info_center.required_votes int 1 run scoreboard players get #menu_required_votes race_state
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"vote_end_confirm"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.vote_action_code set from storage advancement_race:runtime browser_work.action_code
function advancement_race:cooperative/ui/build_active_participant_pages with storage advancement_race:runtime info_center
data modify storage advancement_race:runtime info_center.pages[0].raw.extra insert 7 value {text:" [N9]",color:"#006B73",bold:true,underlined:true,click_event:{action:"change_page",page:13}}
function advancement_race:cooperative/ui/append_n9_participant_pages with storage advancement_race:runtime info_center
data modify storage advancement_race:runtime info_center.pages[0].raw.extra insert 8 value {text:" [N15]",color:"#006B73",bold:true,underlined:true,click_event:{action:"change_page",page:16}}
function advancement_race:cooperative/ui/append_n15_participant_pages with storage advancement_race:runtime info_center
data modify storage advancement_race:runtime info_center.status set value "ready"
