# retro

**retro** gives your coding agent a structured self-improvement loop. After each session it scans what happened — hallucinations, scope creep, behavioral drift, tool misuse, good decisions worth repeating — and acts on the findings by writing memories, updating rules, and maintaining a dated audit log. The longer you use it, the better your agent knows how to work with you.

## Quickstart

Install for [Claude Code](#claude-code).

## How it works

At the end of a session, run `/retro`. The agent reviews the full conversation against 17 behavioral categories, triages findings by severity, and immediately acts on high-confidence ones: writing memory files, updating settings rules, reinforcing positive patterns. Structural changes (new skills, deleted rules) require your approval first. Everything gets logged to `~/.claude/retro-log.md` so you can track trends across sessions.

Before context is compressed, a lightweight hook fires automatically. It captures ephemeral signals — decisions made, corrections given, intent clarifications — that would be lost after compaction, and writes them to memory without interrupting you.

Over time, retro builds up a picture of how you and your agent work best together. Good behaviors get reinforced. Bad patterns get flagged and blocked. The agent gets better at the things that matter to you specifically.

## Installation

### Claude Code

Register the marketplace and install:

```bash
claude plugin marketplace add so0osh/claude-plugin-retro
claude plugin install retro@retro
```

Or from within a Claude Code session:

```
/plugin marketplace add so0osh/claude-plugin-retro
/plugin install retro@retro
```

Restart Claude Code after installation for the hooks to take effect.

## Usage

| Trigger | Skill | When |
|---|---|---|
| `/retro` | `retro` | End of day, after a major delivery, after a long debug session |
| Automatic | `retro-quick` | Fires via `PreCompact` hook before context compression |
| Automatic | reminder | `Stop` hook suggests `/retro` when a session ends |

## What's Inside

### Skills

**retro** — Full on-demand retrospective. Scans the session, presents triaged findings, writes memories and settings updates assertively, gates structural changes behind your approval, appends a dated entry to the audit log.

**retro-quick** — Lightweight pre-compaction capture. Runs automatically before context is compressed. Preserves ephemeral signals (corrections, decisions, intent clarifications) into memory without any user interaction.

### Analysis Rubric

17 detection categories shared by both skills:

| Category | Output |
|---|---|
| Coding quality | memory, audit |
| Best practices | memory, settings |
| Bugs introduced or caught | memory, audit |
| Security issues | memory, settings |
| Behavioral drifts | memory, settings |
| Hallucinations | memory, audit |
| Inaccuracies and ambiguities | memory, audit |
| Intent misinterpretations | memory, audit |
| Good / bad decisions | memory, audit |
| Guesses vs grounded truths | memory, audit |
| Scope creep | memory, settings |
| Tool misuse | memory, settings |
| Confirmation bias | memory, audit |
| Verbosity drift | memory, settings |
| Memory staleness | memory, audit |
| Permission over-reach | settings, audit |
| Positive patterns to reinforce | memory, skill update |

### Outputs

| Artifact | Location | Purpose |
|---|---|---|
| Memory files | `~/.claude/projects/<project>/memory/` | Recalled in future sessions |
| Settings rules | `~/.claude/settings.json` | Enforced rules and hooks |
| Audit log | `~/.claude/retro-log.md` | Cross-session trend record |

## Extension

Add or refine detection categories by editing `shared/analysis-rubric.md`. Each entry needs four fields: what to look for, positive form, negative form, and output type. No changes to the skill files required.

## Contributing

1. Fork the repository
2. Add or improve categories in `shared/analysis-rubric.md`, or refine skill behavior in `skills/retro/SKILL.md` or `skills/retro-quick/SKILL.md`
3. Test with real session data before submitting
4. Submit a PR

## Updating

```bash
claude plugin update retro
```

## License

MIT
