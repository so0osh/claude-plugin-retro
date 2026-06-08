# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/), and the project adheres to
[Semantic Versioning](https://semver.org/).

## [1.1.0] - 2026-06-08

### Fixed
- Pre-compaction capture now actually reaches the model. The previous
  `PreCompact` hook emitted a `systemMessage`, which is only shown to the user
  and cannot trigger a skill, so `retro-quick` never ran.

### Changed
- Reworked pre-compaction capture into a two-stage flow:
  - `PreCompact` snapshots the full transcript to
    `~/.claude/retro-pending/<session_id>.jsonl` before compaction condenses it.
  - `SessionStart` (matcher `compact`) injects `additionalContext` pointing the
    model at the snapshot to run `retro-quick` after compaction completes.
- `retro-quick` now reads the pre-compaction snapshot file (rather than the
  already-compacted live session) and deletes it when finished.

### Added
- `hooks/snapshot-session.ps1` — PreCompact transcript snapshot (fails open).
- `hooks/emit-retro-context.ps1` — SessionStart(compact) trigger.

## [1.0.0]

### Added
- Initial release: `retro` and `retro-quick` skills, 17-category analysis
  rubric, memory/settings/audit-log outputs.
