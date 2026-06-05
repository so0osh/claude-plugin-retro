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

```sh
claude plugin marketplace add so0osh github:so0osh/claude-plugin-retro
claude plugin install retro@so0osh
```

The PreCompact and Stop hooks bundled in `hooks/hooks.json` need to be merged into `~/.claude/settings.json` manually after install. Run `/retro` to verify everything is working.

## When to run /retro

- End of day
- After completing a major feature or delivery
- After a long debugging session
- Anytime you want to check for and lock in behavioral patterns

## Extension

Add detection categories by editing `shared/analysis-rubric.md`. Each entry needs: what to look for, positive form, negative form, output type.

