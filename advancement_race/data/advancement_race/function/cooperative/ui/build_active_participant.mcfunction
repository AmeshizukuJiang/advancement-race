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
function advancement_race:menu/prepare_vote_progress
execute store result storage advancement_race:runtime info_center.vote_count int 1 run scoreboard players get #menu_vote_count race_state
execute store result storage advancement_race:runtime info_center.required_votes int 1 run scoreboard players get #menu_required_votes race_state
data modify storage advancement_race:runtime browser_work.pending_action set value {kind:"vote_end_confirm"}
function advancement_race:browser/session/add_action
data modify storage advancement_race:runtime info_center.vote_action_code set from storage advancement_race:runtime browser_work.action_code
function advancement_race:cooperative/ui/build_active_participant_pages with storage advancement_race:runtime info_center
data modify storage advancement_race:runtime info_center.status set value "ready"
