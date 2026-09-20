$data modify storage advancement_race:runtime coop_history_work.participant set from storage advancement_race:runtime coop_history.participants[$(participant_index)]
scoreboard players operation #coop_history_roster_number race_state = #coop_history_participant_index race_state
scoreboard players add #coop_history_roster_number race_state 1
execute store result storage advancement_race:runtime coop_history_work.participant.roster_number int 1 run scoreboard players get #coop_history_roster_number race_state
function advancement_race:cooperative/ui/history/append_roster_line with storage advancement_race:runtime coop_history_work.participant
