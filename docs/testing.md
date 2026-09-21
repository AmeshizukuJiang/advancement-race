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

# v0.10.0 Beta UI and Browser Validation Record

## Beta.2 — Player UI and Race Navigation

Minecraft 26.2 manual testing passed for the player-facing race navigation,
book generation, localized advancement titles, scoring feedback, vote progress,
and the dark book palette. Written-book component forms and page layouts were
verified in game, including the two-completion-record detail layout.

## Beta.3 — Previous Races and Stale-safe Browser Navigation

The race browser foundation, Previous Races navigation, archived-match routing,
and stale-action rejection were manually tested in Minecraft 26.2. Old browser
actions were rejected after their context became invalid, while fresh
navigation continued to open the intended match. Real non-OP client validation
of `/trigger race_menu` remained deferred because the available test environment
could not reproduce that client role; permission behavior was not claimed as
verified by this test.

## Beta.4 — Unified Info Center and Player Views

Staged Minecraft 26.2 tests passed for UUID-based Status/Result identity,
single-book Info Center replacement, current and archived navigation, live and
final standings, participant details, Advancement Index categories, and
advancement completion details. Tests also covered marked-book inventory
cleanup and event filtering. Display names remained presentation data while
participant and event matching used UUIDs.

## Beta.5 — Administrator Control Book

The Admin Book loaded and opened successfully in Minecraft 26.2 after validating
the written-book command form. Its contents, lifecycle confirmation pages,
registration command template, read-only inspection/validation links, and
player-UI shortcuts were manually exercised. Existing Minecraft command
permissions remained the actual authorization boundary.

## Coverage Boundary

The Beta.2–Beta.5 work primarily changed and tested presentation and navigation.
Catalog validation, generator offline checks, JSON/function-reference checks,
and Minecraft `/reload` checks continued to pass during these stages. These UI
tests do not claim that all 121 vanilla advancements have been naturally
completed. Exhaustive natural-trigger and four-player progression coverage
remains a Release Candidate test objective.

# v1.0.0 Release Validation Record

The release candidate completed four rounds of Minecraft 26.2 real-server
testing:

1. Normal gameplay session — passed.
2. Second normal gameplay session — passed.
3. Creative-mode advancement triggering — passed.
4. `/advancement grant everything` catalog stress test — passed.

The stress test confirmed that multiple advancement scoring events processed
within the same tick still received distinct deterministic place and sequence
values. Final Standings and the unified Info Center displayed the resulting
scores and completion counts correctly.

The historical Info Center shared-result-cache correction was also manually
validated. Historical Participant Detail and Advancement Detail remained bound
to the selected archived match instead of consuming another request's most
recent presentation cache.

These tests verify release loading, the multiplayer gameplay loop, scoring and
event ordering under stress, historical detail isolation, and the principal
player/admin presentation paths. They do not claim that all 121 advancements
were completed through their full natural vanilla progression.

# v1.1.0 Release Candidate Cooperative Test Record

## Scope

The Cooperative Border implementation was tested in staged Minecraft Java
26.2 sessions. These tests verify mechanics and detection paths; they are not a
claim that a complete N9 or N15 game has already been played in survival.

Verified areas include:

- Competitive and Cooperative mode selection, registration, start, end, reset,
  mode switching, `/reload` recovery, and archived-match routing.
- N0–N18 configuration, Border budgets, three-dimension Border synchronization,
  independent Cooperative vanilla rewards, and N18 `-50 Border` challenge
  penalties.
- All 29 N3/N6/N9/N15 custom challenge detection and completion paths, including
  timed attempts, binding/rebinding, failure/reset behavior, consumed supply
  submissions, boss/entity transport objectives, and the 86-entry Flowers
  Beyond placement list.
- Survival, Border, Boss, and independent modifiers, including health
  reapplication, game-rule handling, Border penalties, and strengthened boss
  health.
- Cooperative event ordering, exactly-once team rewards, Team Points, Border
  deltas, Info Center indexes, challenge detail controls, completion markers,
  and Show List output.
- Minecraft `/reload`, generated JSON/function syntax, macros, written-book
  components, catalog validation, and generator drift checks.

The active Cooperative Info Center and Show List presentation passed manual
inspection. The accepted RC UI limitation is that the Vote End link may be
clipped from the Cooperative home page; voting behavior itself is unchanged.

## Remaining RC Gate

The stale-action guards for Eternal Slumber and Shoot Down the Moon, plus the
complete archived Cooperative Challenge History index, were added during the
final pre-commit review and require a short focused Minecraft retest.

After that focused check, the remaining product test is a real multiplayer,
long-form survival session used to evaluate N-level timing and reward balance.
