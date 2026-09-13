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

- Three scored advancement prototypes are implemented:
  - Stone Age (`minecraft:story/mine_stone`), base score **100**.
  - A Seedy Place (`minecraft:husbandry/plant_seed`), base score **100**.
  - Monster Hunter (`minecraft:adventure/kill_a_mob`), base score **200**.
- A shared scoring core applies the confirmed completion-order multipliers: **100% / 80% / 60% / 40% / 20%** for first / second / third / fourth / fifth and later. It preserves the all-chat announcement and Actionbar notification for each advancement.
- Each advancement has its own completion counter. `race_place`, `race_award`, and `race_points` retain their defined semantics below.
- A Storage event ledger records sequence, player UUID, registered in-match name, advancement ID, place, and awarded points.
- A minimal Match Lifecycle is implemented: participants can be registered while idle; starting locks the roster and enables scoring only for registered players; ending archives the match snapshot under `history.matches` while retaining the current match snapshot; resetting prepares a new match without clearing archived history. Registering revokes the participant's helper advancements so they can trigger in the next match.
- `tools/advancements.manifest.json` is a static metadata prototype for these three advancements. It does not generate datapack files and is not read by runtime datapack logic.

Do not assume generator-based advancement support, 100+ advancement coverage, historical query tools, settlement, final rankings, or written book reports are implemented.

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
- Add match lifecycle operations: start, end, reset, and settlement.
- Generate a final leaderboard and a written book report for each player.
- Once the data model is established, use a manifest and generator to maintain 100+ helper advancements.

## Development Workflow

Use **Plan → Implement → Review → Manual Minecraft Test → Commit**.

- Minecraft runtime behavior must be manually tested by the user.
- For manual Minecraft tests, default to using `LowiroLimited`, `Alex`, and `Steve`. `LowiroLimited` is the user's real game player; `Alex` and `Steve` are Carpet fake players for development testing. Design tests to cover requirements with these three players first. Suggest additional fake players only when a test genuinely requires more independent players. This is a development/testing convention only: it must not become a data pack runtime dependency, and player names must not be hard-coded into data pack logic.
- Do not commit until the user confirms the Minecraft test passed.
- Discuss significant architecture changes before implementing them.
- Do not expand the current stage for future requirements.
- Avoid unrelated refactoring.
- Internal implementation details may be chosen independently when they do not change product behavior or create significant migration or compatibility consequences.

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
