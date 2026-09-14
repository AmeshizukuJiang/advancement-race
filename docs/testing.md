# v0.9.4 Stabilization Test Report

## Environment

- Minecraft version: 26.2
- Datapack version: v0.9.4
- Test type: clean runtime verification
- Participants used:
  - LowiroLimited
  - Alex
  - Steve
  - Invalid (negative test)

## Test Coverage

### Lifecycle

The following lifecycle operations were verified in Minecraft 26.2:

- `/reload` completed without a data pack function parse error.
- `match/reset` prepared a new match and cleared the active state.
- LowiroLimited, Alex, and Steve were registered for a match.
- `match/start` started the prepared match and locked the roster.
- Scoring occurred while the match was active.
- `match/end` ended the match and archived its snapshot.
- A reset after an ended match prepared the next match without deleting history.
- A second match was created with a new match ID.

### Scoring

Advancement detection, completion place calculation, score multipliers, and event-ledger writes were verified with these examples:

- Hot Stuff (`minecraft:story/lava_bucket`): first completion awarded 200 points; second completion awarded 160 points.
- Stone Age (`minecraft:story/mine_stone`): first completion awarded 100 points; second completion awarded 80 points.
- We Need to Go Deeper (`minecraft:story/enter_the_nether`): first completion awarded 300 points; second completion awarded 240 points.

These observations confirm that first completion receives the full base score and later completion receives the configured reduced multiplier.

The archived first match contained six ordered events. Each event retained its sequence, player UUID, registered player name, vanilla advancement ID, place, and actual awarded points. Sequence values were continuous from 1 through 6.

The second match also verified that helper advancements are revoked during reset/register: players could score the same supported advancement again in the new match. A repeat trigger within the same match did not create a second score event. An unregistered fake player (`Invalid`) could obtain Stone Age without producing an Advancement Race score announcement, confirming the active-match registration gate.

### Books

Lobby Book, Status Book, and Result Book were verified in Minecraft 26.2:

- Written books generated successfully.
- Book pages displayed the expected content correctly.
- Lobby Book was available in the prepared lobby and rejected while a match was active.
- Status Book and Result Book displayed their calculated snapshots correctly.
- Player Actionbar messages worked correctly during scoring.

Known limitation: book `give` functions currently depend on a previously generated runtime cache. Calling a book `give` function before its corresponding `calculate` function can display stale runtime data from an earlier calculation. This is a presentation-layer issue planned for future wrapper validation; it does not affect scoring, event-ledger integrity, match lifecycle data, or history archives.

### Vote End

The end-vote flow was verified:

- A registered participant could cast a vote during an active match.
- A single vote in a three-player roster did not end the match.
- A second registered-participant vote reached a majority and automatically ended the match.
- A non-participant did not receive scoring credit after triggering an advancement during an active match.

### Admin Diagnostics

The following read-only diagnostics were exercised:

- `admin/inspect_match`
- `admin/inspect_vote`
- `admin/inspect_runtime`
- `admin/validate`

Validation correctly reported match-state consistency, participant index bounds, vote-count bounds, and archive presence. `inspect_vote` correctly identified vote data from an earlier match as stale when a new active match had a different match ID, reported effective current voters as zero, and did not modify match facts.

Expected read-only WARN messages were observed for conditions that cannot be fully enumerated without altering storage, including individually stored voter indices. These warnings did not modify match facts.

### Multi-match Persistence

Multi-match persistence was verified:

- Ending a match appended an archive to `history.matches`.
- Reset retained previous archives.
- The next match received a new match ID.
- A previous match's vote data was identified as stale and did not count toward the new active match.

## Known Issues / Future Work

1. Add book freshness validation before `give`.
2. Improve the user experience around stale runtime presentation caches.

These items are presentation-layer improvements and are not classified as issues affecting scoring or match integrity.

## Result

v0.9.4 passed stabilization testing. Core gameplay loop, scoring, event ledger, lifecycle, vote ending, books, and history persistence were verified in Minecraft 26.2.

# v0.10.0-beta.1 Catalog Expansion Test Record

## Scope

- The scored catalog was expanded from 40 to all 121 approved non-root gameplay advancements in the five standard vanilla tabs.
- The scoring algorithm, Match Lifecycle, event ledger, `history.matches` schema, vote system, and Lobby, Status, and Result Book architecture were not changed in Beta.1.

## Engineering Verification

- Manifest completeness and catalog validation passed against the Mojang-verified Minecraft 26.2 server artifact.
- The generator's offline `--check` passed for all managed outputs.
- JSON validation, function-reference validation, and `git diff --check` passed.
- Minecraft 26.2 `/reload` completed without datapack, function, or advancement JSON loading errors.
- Representative newly added advancements were manually completed and detected successfully.

## Deferred Release Candidate Coverage

Exhaustive gameplay validation of all 121 advancements is intentionally deferred to the Release Candidate phase. That phase will use repeated real multiplayer progression testing with four human players. This deferral does not weaken or simplify any copied vanilla advancement criteria.
