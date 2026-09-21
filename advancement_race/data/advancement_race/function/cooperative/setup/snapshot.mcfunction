# Snapshot the prepared selection without applying the future v1.1 balance model yet.
data modify storage advancement_race:match rules.cooperative.v11 set from storage advancement_race:match setup.cooperative
data modify storage advancement_race:match rules.cooperative.v11.reward_schema_version set value 1
data modify storage advancement_race:match rules.cooperative.v11.custom_challenge_catalog_size set value 29
data modify storage advancement_race:match rules.cooperative.v11.n18_custom_challenge_border_delta set value -50
function advancement_race:cooperative/setup/resolve_snapshot with storage advancement_race:match rules.cooperative.v11
function advancement_race:cooperative/setup/resolve_boss_snapshot with storage advancement_race:match rules.cooperative.v11.modifiers
function advancement_race:cooperative/setup/apply_profile
