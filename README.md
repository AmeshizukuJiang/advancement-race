# Advancement Race

Advancement Race is a vanilla Minecraft Java Edition **26.2** data pack for
multiplayer games based on vanilla advancements. It supports the original
competitive race and a Cooperative Border mode built around shared progression,
custom challenges, and a shrinking three-dimension World Border.

## Current development — v1.1.0 release candidate

The v1.1 release candidate adds Cooperative Border without changing the v1.0
Competitive scoring rules. A single registered team works toward all 121
vanilla gameplay advancements plus the custom challenges enabled by its chosen
difficulty.

- N0–N18 difficulty profiles control the Border budget, vanilla rewards, game
  difficulty, and cumulative challenge packs.
- N3, N6, N9, and N15 unlock 29 custom challenges in total.
- Vanilla and custom objectives award independent Cooperative Team Points and
  Border distance. At N18, custom objectives retain their Team Points but apply
  `-50` Border.
- Optional Survival, Border, Boss, and independent modifiers produce a separate
  Challenge Rating.
- The Cooperative Info Center provides a Vanilla Index, Challenge Index,
  challenge controls, completion markers, rules, live totals, and historical
  challenge results.

All values remain subject to multiplayer balance testing. The implementation
has passed staged Minecraft 26.2 mechanic tests; the first full long-form
survival playtest is the remaining RC balance gate.

## Stable release — v1.0.0

**Stable release — complete multiplayer flow and full gameplay catalog**

The scored catalog contains all **121** non-root gameplay advancements from
Story, Nether, End, Adventure, and Husbandry. Recipe advancements and the five
tab roots are excluded. Catalog integrity is validated against the verified
Minecraft 26.2 server artifact, and the complete generated catalog loads
successfully in Minecraft 26.2.

The Beta and Release Candidate series added a unified Info Center, localized
advancement information, live and final standings, participant and advancement
details, Previous Races, stale-safe navigation, and an administrator control
book. v1.0.0 passed four rounds of Minecraft 26.2 server testing: two normal
gameplay sessions, a Creative-mode trigger pass, and an
`/advancement grant everything` stress test. This validation does not claim
that every advancement was completed through its full natural progression.

## Installation

Copy the complete [`advancement_race`](advancement_race) directory—the folder
that directly contains `pack.mcmeta` and `data/`—into the world's `datapacks`
directory. The resulting layout should be:

```text
<world>/datapacks/advancement_race/pack.mcmeta
<world>/datapacks/advancement_race/data/
```

If distributing it as a zip, `pack.mcmeta` and `data/` must be at the root of
the zip rather than inside an extra wrapper directory. Start or reload the
world, then confirm `/reload` reports no data pack, function, or advancement
loading errors.

## Player workflow

Players use one command throughout the race:

```mcfunction
/trigger race_menu
```

This opens or refreshes a single marked Info Center book. It shows the current
match state and only the actions relevant at that time:

1. **Lobby:** view registration state, the current roster, and the next step.
2. **Active match:** view personal status, Live Standings, the Advancement
   Index, participant/advancement details, and the confirmed vote-to-end flow.
3. **Ended or idle state:** open Previous Races and browse archived matches,
   including personal results, Final Standings, participant details, and
   advancement completion details.

Registration remains host/admin controlled. An unregistered player
should ask the host to add them; `/trigger race_menu` does not self-register a
player.

## Host / admin workflow

Prepare a new lobby:

```mcfunction
/function advancement_race:match/reset
```

Use the Admin Book to keep Competitive mode or select Cooperative Border. For
Cooperative Border, configure N difficulty and optional modifiers before the
match starts; the selected setup is snapshotted into that match's history.

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
Administrators can obtain the control book with:

```mcfunction
/function advancement_race:admin_book/give
```

The Admin Book provides organized lifecycle, registration-template,
diagnostic, validation, and player-UI shortcuts. It is a convenience UI, not a
permission boundary; Minecraft still enforces the permissions required by each
command.

## Race feedback and books

- Chat announces each scoring event globally with the player, localized
  advancement title, Advancement Place, and awarded points.
- The global Actionbar provides a compact scoring update and current total.
- The unified Info Center shows lobby state, live status, final results,
  standings, advancement categories, and archived matches.
- Live and final participant details show points, rank, completion count, and
  that participant's events.
- Advancement details show the base score, completion count, finishers, place,
  and awarded points.
- Detail pages preserve event sequence, Advancement Place, and actual awarded
  points while using vanilla-localized advancement titles.
- Dynamic historical details reconstruct and validate the selected match before
  reading their temporary result cache.

Advancement titles use the player's Minecraft language through vanilla
translation keys. Match history continues to store stable vanilla advancement
IDs rather than localized text.

## Developer / debug functions

Normal players should use `/trigger race_menu`, not internal function paths.
The following legacy public wrappers remain available for development and
diagnostics:

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
python tools/validate_cooperative_config.py
python tools/generate_cooperative_config.py --check
```
