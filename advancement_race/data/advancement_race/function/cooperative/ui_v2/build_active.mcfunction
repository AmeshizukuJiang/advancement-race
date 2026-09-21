function advancement_race:cooperative/ui/prepare_active
function advancement_race:cooperative/ui_v2/prepare_actions
function advancement_race:cooperative/ui_v2/generated/prepare_generated
data modify storage advancement_race:runtime info_center.pages set value []
function advancement_race:cooperative/ui_v2/generated/build_pages_generated with storage advancement_race:runtime info_center
function advancement_race:cooperative/ui_v2/generated/populate_generated
data modify storage advancement_race:runtime info_center.status set value "ready"
