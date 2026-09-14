# Read-only view of presentation caches. None of these caches are match facts.
tellraw @s [{"text":"[Admin] Runtime presentation caches (not match facts)"}]
execute if data storage advancement_race:runtime result run tellraw @s [{"text":"Result cache: present; status="},{"storage":"advancement_race:runtime","nbt":"result.status"}]
execute unless data storage advancement_race:runtime result run tellraw @s [{"text":"Result cache: absent"}]
execute if data storage advancement_race:runtime status run tellraw @s [{"text":"Status cache: present; status="},{"storage":"advancement_race:runtime","nbt":"status.status"}]
execute unless data storage advancement_race:runtime status run tellraw @s [{"text":"Status cache: absent"}]
execute if data storage advancement_race:runtime lobby_book run tellraw @s [{"text":"Lobby Book cache: present; status="},{"storage":"advancement_race:runtime","nbt":"lobby_book.status"}]
execute unless data storage advancement_race:runtime lobby_book run tellraw @s [{"text":"Lobby Book cache: absent"}]
