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

- Only Stone Age (`minecraft:story/mine_stone`) is implemented.
- Stone Age awards by completion place: **100 / 80 / 60 / 40 / 20** points for first / second / third / fourth / fifth and later.
- Completion announcements and Actionbar messages are implemented.
- Participants can be registered manually for a match.
- A Stone Age event ledger is stored in Storage. Each event records sequence, player UUID, registered in-match name, advancement ID, place, and points.

Do not assume other advancements, a complete match lifecycle, final rankings, or written books are already implemented.

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
