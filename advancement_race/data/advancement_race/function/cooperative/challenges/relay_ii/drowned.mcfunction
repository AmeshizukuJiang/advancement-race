advancement revoke @s only advancement_race_coop:relay_ii/drowned
execute if score @s race_participant matches 0.. run function advancement_race:cooperative/challenges/relay_ii/objective {field:"drowned",label:"Drowned"}
