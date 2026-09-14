# Advancement Race — Agent Instructions

## Project Goal

- Target Minecraft Java Edition **26.2**, Data Pack version **107.1**.
- Build a multiplayer Advancement Race as a vanilla data pack.
- Players earn points for completing vanilla advancements. Each advancement has a base score, and awards depend on completion order.
- Long-term goal: support 100+ vanilla advancements, show a final leaderboard, and give each player a written book with their race results.

## Runtime Constraints

- The released project must remain a vanilla data pack.
- Carpet may be used for development and testing, but must not be a runtime dependency.
- Do not introduce Fabric or server mods as scoring dependencies unless the user explicitly changes the product direction.

## Confirmed Architecture

- **Helper Advancements:** detect vanilla advancement completion and provide one-time triggering. Do not modify vanilla advancements.
- **Scoreboard:** real-time integer totals, scoring calculations, and temporary state.
- **Storage:** persistent race history and structured race data. Treat Storage events as the historical source of truth; scoreboard values are fast summary views.

## Current Implemented State

- All **121** non-root gameplay advancements in the five standard vanilla tabs
  (Story, Nether, End, Adventure, and Husbandry) are configured as scored
  catalog entries. Recipe unlocks and the five tab roots are excluded. The
  original ten include:
  - Stone Age (`minecraft:story/mine_stone`), base score **100**.
  - A Seedy Place (`minecraft:husbandry/plant_seed`), base score **100**.
  - Monster Hunter (`minecraft:adventure/kill_a_mob`), base score **200**.
  - Getting an Upgrade (`minecraft:story/upgrade_tools`), base score **100**.
  - Acquire Hardware (`minecraft:story/smelt_iron`), base score **150**.
  - Hot Stuff (`minecraft:story/lava_bucket`), base score **200**.
  - We Need to Go Deeper (`minecraft:story/enter_the_nether`), base score **300**.
  - Sweet Dreams (`minecraft:adventure/sleep_in_bed`), base score **100**.
  - Fishy Business (`minecraft:husbandry/fishy_business`), base score **150**.
  - What a Deal! (`minecraft:adventure/trade`), base score **200**.
- The shared scoring core is unchanged. It applies the confirmed completion-order multipliers: **100% / 80% / 60% / 40% / 20%** for first / second / third / fourth / fifth and later, and preserves the all-chat announcement and Actionbar notification for each advancement.
- Each advancement has its own completion counter. `race_place`, `race_award`, and `race_points` retain their defined semantics below.
- A Storage event ledger records sequence, player UUID, registered in-match name, advancement ID, place, and awarded points.
- A minimal Match Lifecycle is unchanged: participants can be registered while idle; starting locks the roster and enables scoring only for registered players; ending archives the match snapshot under `history.matches` while retaining the current match snapshot; resetting prepares a new match without clearing archived history.
- Counter initialization, counter reset, and helper revocation are each maintained by a dedicated shared function. Registering revokes a participant's helpers so they can trigger in the next match.
- `tools/advancements.manifest.json` contains static metadata for all 121 scored advancements. Runtime Storage does not duplicate this configuration.
- `tools/generate_advancements.py` uses the manifest and a verified Mojang Minecraft 26.2 server artifact to generate the helper advancements, reward functions, and counter aggregate functions. Generated runtime files remain tracked in Git; the downloaded artifact cache remains outside the repository.
- Result calculation and the personal Result Book read ended-match history through their dedicated runtime result data.
- Status calculation and the personal Status Book read the active match through dedicated runtime status data.
- The Lobby Book presents the prepared roster and the caller's registration state. A registered-participant majority may end an active match through the separate end-vote feature.

Do not assume automatic expansion beyond the manifest, leaderboards, query books, or settlement reports are implemented.

## Important Variable Semantics

- `race_place`: place for the most recent scored advancement; **not** the overall rank.
- `race_award`: points awarded by the most recent scoring event.
- `race_points`: player’s current accumulated total score.
- `#stone_age_count`: server-wide Stone Age completion count.
- Use Storage events for historical places and awards; do not treat temporary scoreboard values as history.
- Use a separate concept such as `race_rank` for future overall leaderboard rank.

## Long-Term Direction

- Configure a base score for each scored advancement.
- Target completion-order award tiers: **100% / 80% / 60% / 40% / 20%** for first / second / third / fourth / fifth and later. Confirm rule changes with the user.
- Preserve player × advancement completion history.
- Extend the implemented lifecycle with settlement only after its player-visible behavior is designed.
- Generate leaderboard and richer multi-player book reports beyond the existing personal Result, Status, and Lobby books.
- Use the manifest and generator to maintain the 121-advancement catalog and future catalog changes.

## Development Workflow

Use **Plan → Implement → Review → Manual Minecraft Test → Commit**.

- Minecraft runtime behavior must be manually tested by the user.
- For manual Minecraft tests, default to using `LowiroLimited`, `Alex`, and `Steve`. `LowiroLimited` is the user's real game player; `Alex` and `Steve` are Carpet fake players for development testing. Design tests to cover requirements with these three players first. Suggest additional fake players only when a test genuinely requires more independent players. This is a development/testing convention only: it must not become a data pack runtime dependency, and player names must not be hard-coded into data pack logic.
- Do not commit until the user confirms the Minecraft test passed.
- Discuss significant architecture changes before implementing them.
- Do not expand the current stage for future requirements.
- Avoid unrelated refactoring.
- Internal implementation details may be chosen independently when they do not change product behavior or create significant migration or compatibility consequences.

## Minecraft 26.2 Syntax and Data Rules

- For nested NBT paths, use dot notation such as `result_request.match_id`; do not separate nested fields with spaces.
- Validate actual Minecraft command syntax before relying on a new Storage, function-macro, or written-book JSON form. When uncertain, first create a minimal test function or command.
- Written-book components must be tested in-game. In particular, do not emit invalid empty component lists such as `extra:[]`; an empty roster page should omit `extra` instead.
- The event ledger is the historical source of truth. Lobby, Status, and Result Books are read-only presentation layers and must never become a data source.
- Do not change `history.matches` or the event schema merely to make a UI feature easier. Keep UI code isolated from scoring, event recording, and Match Lifecycle behavior.

## Admin Diagnostics and Test Tools

- `admin/inspect_*` and `admin/validate` are read-only diagnostic functions. They must not write Storage or alter match, event, history, vote, scoring, or lifecycle facts.
- `admin/validate` reports `PASS` for verified invariants, `WARN` for normal absence or deliberate read-only limits, and `FAIL` for detected inconsistencies. A WARN is not an automatic repair request.
- Debug diagnostics must never mutate fact data. Any explicit development-only injection tool belongs under `admin/test`, stays outside normal match entry points, and must not be used to repair or simulate production facts.

## Generated Runtime Files

- Do not hand-edit generated helper advancements, reward functions, or generated counter aggregate functions.
- Update the manifest or generator input, regenerate the runtime files, and run the generator with `--check` to prevent drift.
- Keep manually maintained overrides, including the Monster Hunter override, outside the generated-file boundary.

## Decision Boundary

Ask the user before decisions affecting:

- Player-visible behavior
- Scoring rules
- Match lifecycle
- Production runtime dependencies
- Data format, compatibility, or migration
- Large-scale refactoring
- The scope of the current stage

Usually decide independently on:

- Internal function decomposition
- Local naming
- File organization
- Static checks
- Implementation details that do not change product behavior

## Git Discipline

- Main branch: `master`
- Remote: `origin`
- Commit only after the user confirms Minecraft testing passed.
- Keep commits stage-based, clear, and single-purpose.
- Do not push automatically; push only when the user explicitly asks.
