advancement revoke @s only advancement_race_coop:relay/zombie
execute if score @s race_participant matches 0.. run function advancement_race:cooperative/challenges/relay/objective {field:"zombie",label:"Zombie"}
