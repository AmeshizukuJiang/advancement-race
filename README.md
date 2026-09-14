# Advancement Race

Advancement Race is a vanilla Minecraft Java Edition **26.2** data pack for
multiplayer races based on vanilla advancements. Each advancement has a base
score, and players receive fewer points when other players complete that same
advancement first.

## Current development status — v0.10.0-beta.2

**Player UI / UX Polish — implementation ready for Minecraft testing**

The scored catalog contains all **121** non-root gameplay advancements from
Story, Nether, End, Adventure, and Husbandry. Recipe advancements and the five
tab roots are excluded. Minecraft 26.2 successfully loaded the complete catalog
in Beta.1; exhaustive real-gameplay catalog testing remains planned for the
Release Candidate phase.

Beta.2 adds a normal-player menu, clearer race feedback, vote progress,
localized advancement titles in books, and book layouts sized for the full
catalog. These Beta.2 presentation changes still require Minecraft 26.2 manual
verification before release.

## Player workflow

Players use one command throughout the race:

```mcfunction
/trigger race_menu
```

The menu shows the current match state and only the actions relevant at that
time:

1. **Lobby:** view the Lobby Book, registration state, and current roster.
2. **Active match:** view a fresh Status Book or vote to end the match.
3. **Ended match:** view the latest personal Result Book.

Registration remains host/admin controlled in Beta.2. An unregistered player
should ask the host to add them; `/trigger race_menu` does not self-register a
player.

## Host / admin workflow

Prepare a new lobby:

```mcfunction
/function advancement_race:match/reset
```

Register each player with the name that should be recorded in race history:

```mcfunction
/function advancement_race:match/register {player:"@a[name=LowiroLimited]",name:"LowiroLimited"}
```

Start the prepared match:

```mcfunction
/function advancement_race:match/start
```

The roster locks when the match starts. During the race, registered players can
vote to end through `/trigger race_menu`; a strict majority invokes the existing
match-end flow. The host may also end the match directly:

```mcfunction
/function advancement_race:match/end
```

Read-only administrator diagnostics remain available under
`advancement_race:admin/inspect_*` and `advancement_race:admin/validate`.

## Race feedback and books

- Chat announces each scoring event globally with the player, localized
  advancement title, Advancement Place, and awarded points.
- The global Actionbar provides a compact scoring update and current total.
- The Lobby Book shows registration state and roster.
- The Status Book shows live points, Current Rank, and completed advancements.
- The Result Book shows Final Points, Final Rank, and completed advancements.
- Status and Result detail pages preserve event sequence, Advancement Place,
  and actual awarded points while fitting two records per page.

Advancement titles use the player's Minecraft language through vanilla
translation keys. Match history continues to store stable vanilla advancement
IDs rather than localized text.

## Developer / debug functions

Normal players should not use internal function paths. The following remain
available for development and diagnostics:

```mcfunction
/function advancement_race:book/lobby
/function advancement_race:book/status
/function advancement_race:book/result_latest
/function advancement_race:book/result_match {match_id:1}
```

Lower-level `status/calculate`, `result/calculate_*`, and `*_book/give`
functions work with temporary presentation data. They are implementation and
debug interfaces, not the normal player workflow.

Carpet may be used to create fake players for development testing, but it is
not a runtime dependency.

## Development notes

The event ledger and archived matches are the historical source of truth.
Scoreboards are real-time working values, while Lobby, Status, and Result books
are presentation layers.

Generated runtime files are tracked in Git. Change their manifest or generator
input, regenerate them, and use `--check` rather than editing generated files by
hand.

For a full catalog and generated-output check against the cached
Mojang-verified Minecraft 26.2 server artifact, run:

```text
python tools/validate_catalog.py --offline
python tools/generate_advancements.py --offline --check
```
