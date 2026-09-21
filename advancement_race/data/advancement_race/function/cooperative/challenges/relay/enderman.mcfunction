advancement revoke @s only advancement_race_coop:relay/enderman
execute if score @s race_participant matches 0.. run function advancement_race:cooperative/challenges/relay/objective {field:"enderman",label:"Enderman"}
