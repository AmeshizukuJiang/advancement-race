data modify storage advancement_race:runtime cooperative_penalty set value {kind:"modifier_penalty",id:"failure_tax",source:"calamity_relay",border_delta:-250}
function advancement_race:cooperative/events/record_system
tellraw @a [{"text":"Failure Tax","color":"red","bold":true},{"text":" | Timed challenge failed · Border -250","color":"red","bold":false}]
function advancement_race:cooperative/border/apply_penalty
