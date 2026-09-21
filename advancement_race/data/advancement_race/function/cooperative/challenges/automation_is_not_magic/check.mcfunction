execute store result score #automation_iron race_state run data get storage advancement_race:match cooperative.challenges.automation_is_not_magic.iron
execute store result score #automation_dried_kelp race_state run data get storage advancement_race:match cooperative.challenges.automation_is_not_magic.dried_kelp
execute store result score #automation_fireworks race_state run data get storage advancement_race:match cooperative.challenges.automation_is_not_magic.fireworks
execute store result score #automation_honey race_state run data get storage advancement_race:match cooperative.challenges.automation_is_not_magic.honey
execute if score #automation_iron race_state matches 64.. if score #automation_dried_kelp race_state matches 32.. if score #automation_fireworks race_state matches 64.. if score #automation_honey race_state matches 8.. run function advancement_race:cooperative/challenges/automation_is_not_magic/complete
