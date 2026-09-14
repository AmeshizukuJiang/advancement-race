# Advancement Race

Advancement Race is a vanilla Minecraft Java Edition **26.2** data pack and
framework for multiplayer races based on vanilla advancements. Each configured
advancement awards points according to its base score and the order in which
players complete it.

## Current development status — v0.10.0-beta.1

**121-advancement catalog engineering expansion — Minecraft 26.2 reload verified**

Minecraft 26.2 loaded the expanded data pack without datapack, function, or
advancement JSON errors. Representative newly added advancements were manually
completed and detected successfully. Exhaustive gameplay validation of all 121
advancements is intentionally deferred to the Release Candidate phase, using
repeated four-player multiplayer testing.

The project currently provides:

- Advancement scoring with per-advancement base scores and completion-order
  awards.
- All 121 non-root gameplay advancements in the five standard vanilla tabs
  (Story, Nether, End, Adventure, and Husbandry) are configured as scored
  catalog entries. Their helper conditions are copied from the verified
  Minecraft 26.2 server artifact; recipe and tab-root advancements are not
  included.
- A generator pipeline and static advancement manifest maintain generated
  helper advancements, reward functions, and counter aggregate functions.
- Match lifecycle operations for preparing, registering, starting, ending, and
  resetting matches.
- A persistent Storage event ledger and archived match history.
- Lobby, live Status, and final Result books for player-facing views.
- Participant-majority voting to end an active match.
- Read-only administrator inspection and validation functions for match, vote,
  and runtime presentation-cache diagnostics.

## Typical match flow

```text
Lobby → Register → Start → Status → Vote End → Result
```

1. Prepare a lobby, then register players with the existing administrator
   registration function and its explicit player-name argument.
2. Start the match. The roster is locked and only registered participants can
   score.
3. Players can request a fresh Status Book for the active match.
4. Registered participants may vote to end the match; a strict majority ends
   it.
5. After the match ends, issue each participant a Result Book for the latest
   ended match.

## Public book commands

Use these public entry points during normal play. They validate the applicable
match state and calculate a fresh presentation snapshot before issuing a book.

```mcfunction
/function advancement_race:book/lobby
/function advancement_race:book/status
/function advancement_race:book/result_latest
/function advancement_race:book/result_match {match_id:1}
```

`book/lobby` is available only for a prepared lobby. `book/status` is available
only during an active match. `book/result_latest` uses the most recently ended
match, while `book/result_match` selects a specific archived ended match.

The lower-level `status/calculate`, `result/calculate_*`, and `*_book/give`
functions remain available for development and debugging. They operate on
runtime presentation caches and are not the recommended normal-play workflow.

Carpet is useful for development and manual testing, but it is not a runtime
dependency of the released data pack.

## Development notes

The event ledger and archived matches are the historical source of truth.
Scoreboards are real-time working values, while Lobby, Status, and Result books
are read-only presentation layers.

Generated runtime files are tracked in Git. Change their manifest or generator
input, regenerate them, and run the generator's `--check` mode rather than
editing generated files by hand.

For a full catalog integrity check against the cached Mojang-verified Minecraft
26.2 server artifact, run:

```text
python tools/validate_catalog.py --offline
python tools/generate_advancements.py --offline --check
```
