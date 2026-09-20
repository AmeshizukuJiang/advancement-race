$data modify storage advancement_race:runtime coop_history set from storage advancement_race:history matches[{id:$(match_id),status:"ended",mode:"cooperative_border"}]
$execute if data storage advancement_race:runtime coop_history{id:$(match_id)} run function advancement_race:cooperative/ui/history/build
$execute unless data storage advancement_race:runtime coop_history{id:$(match_id)} run tellraw @s [{"text":"That Cooperative Border match is no longer available.","color":"#9B2226"}]
