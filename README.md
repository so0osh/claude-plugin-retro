# retro

Session retrospective skill for Claude Code. Captures behavioral patterns, writes memories, enforces rules, and maintains a dated audit log across sessions.

## Skills

| Skill | Trigger | Depth |
|---|---|---|
| `retro` | `/retro` (on-demand) | Full — analysis, memory, settings, audit |
| `retro-quick` | `PreCompact` hook (automatic) | Lightweight — memory and audit only |

## Outputs

| Artifact | Location |
|---|---|
| Memory files | `~/.claude/projects/<project>/memory/` |
| Settings rules | `~/.claude/settings.json` |
| Audit log | `~/.claude/retro-log.md` |

## Installation

1. This directory is already in `~/.claude/plugins/cache/retro/1.0.0/`
2. Merge hooks from `hooks/hooks.json` into `~/.claude/settings.json` (see Task 10 of implementation plan)
3. Run `/retro` to verify the full skill works

## When to run /retro

- End of day
- After completing a major feature or delivery
- After a long debugging session
- Anytime you want to check for and lock in behavioral patterns

## Extension

Add detection categories by editing `shared/analysis-rubric.md`. Each entry needs: what to look for, positive form, negative form, output type.

## Marketplace

Designed for `claude-plugins-official/retro`. Spec: `docs/superpowers/specs/2026-06-05-retro-design.md`.
