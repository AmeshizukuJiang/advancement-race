function advancement_race:cooperative/ui/prepare_active
function advancement_race:cooperative/ui/build_active_observer_pages with storage advancement_race:runtime info_center
data modify storage advancement_race:runtime info_center.pages[0].raw.extra insert 7 value {text:" [N9]",color:"#006B73",bold:true,underlined:true,click_event:{action:"change_page",page:7}}
function advancement_race:cooperative/ui/append_n9_observer_pages with storage advancement_race:runtime info_center
data modify storage advancement_race:runtime info_center.pages[0].raw.extra insert 8 value {text:" [N15]",color:"#006B73",bold:true,underlined:true,click_event:{action:"change_page",page:9}}
function advancement_race:cooperative/ui/append_n15_observer_pages with storage advancement_race:runtime info_center
data modify storage advancement_race:runtime info_center.status set value "ready"
