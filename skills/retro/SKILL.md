---
name: retro
description: Use at end-of-day, after a major delivery, or any deliberate reflection point to review behavioral patterns, quality issues, and insights from the session worth preserving or acting on.
---

# retro — Session Retrospective

## Overview

A structured self-improvement retrospective. Scans the session against 17 behavioral categories, acts assertively on high-confidence findings, gates on user approval for structural changes, and appends a dated entry to the audit log.

## CRITICAL: This is an action task, not a report task

Do NOT produce a findings document and stop. Work through all 7 steps. Write the memory files. Mutate the settings where applicable. Log the entry. The output is persistent artifacts, not a conversation response.

## CRITICAL: Skill file updates require explicit user approval

Do NOT update any skill files (including any files under the retro plugin directory) without first asking the user for approval. Skill mutations are gated. Writing to memory files and settings.json is assertive (automatic).

## Process

### Step 1: Scan session context

Review the full conversation: all tool calls made, files edited, decisions taken, errors encountered, user corrections given, turns where user praised or corrected behavior.

### Step 2: Run rubric analysis

Read the rubric at `../../shared/analysis-rubric.md` relative to this skill's base directory (shown at the top of this skill when loaded). Evaluate each of the 17 categories against the session evidence. For each finding assign:

- **Confidence:** high (clear evidence), medium (pattern suggested), low (possible but uncertain)
- **Impact:** high (will affect future sessions repeatedly), medium (occasional), low (one-off)
- **Polarity:** positive (reinforce) / negative (fix or flag)

Only include findings with at least medium confidence.

### Step 3: Present findings summary

Output this before taking any write action — give the user visibility first:

```
## Retro Findings — YYYY-MM-DD HH:MM

**Session:** <working directory> | ~N turns

### [HIGH] Negative
- <Category>: <what happened> (turn N)

### [MED] Negative
- <Category>: <what happened> (turns N-M)

### [LOW] / Positive
- <Category>: <what happened> × N occurrences
```

### Step 4: Apply assertive changes automatically

No approval needed for these — just do them:

| Change | How |
|---|---|
| Write/update a memory file | Use Write/Edit on `~/.claude/projects/<project>/memory/` |
| Update an existing settings rule | Use Edit on `~/.claude/settings.json` |
| Add a known, already-configured hook type | Use Edit on `~/.claude/settings.json` |

For memory files, use the standard frontmatter format:

```markdown
---
name: <kebab-case-slug>
description: <one-line summary>
metadata:
  type: feedback | user | project | reference
---
<content — lead with fact, then **Why:** and **How to apply:** lines>
```

Check `MEMORY.md` first — update existing entries rather than duplicating.

### Step 5: Gate structural changes — ask first

ASK BEFORE applying any of these:

- Creating a new skill file
- Editing any existing skill file (including any files under the retro plugin directory)
- Deleting or overriding an existing memory or rule
- Adding a hook event type not currently in `settings.json`

Format the ask:
> "Found: [X]. Proposed action: [Y]. Apply? (y/n)"

Wait for explicit confirmation before proceeding. Apply only if confirmed.

### Step 6: Write audit log entry

Prepend to `~/.claude/retro-log.md` (create if it doesn't exist, newest entries at TOP):

```markdown
## YYYY-MM-DD HH:MM — Full Retro

**Session:** <absolute working directory> | ~N turns
**Triggered:** on-demand

### Findings
- [HIGH] <Category>: <description> → <action taken>
- [MED] <Category>: <description> → <action taken>
- [LOW] <Category>: <description> → noted only

### Changes Applied
- `<memory file path>` — <what changed>
- `settings.json` — <what changed, or "no changes">
- Approved by user: <comma-separated list, or "none required this session">

### Positive Patterns Endorsed
- <pattern description> × N occurrences
```

Replace YYYY-MM-DD HH:MM with the actual current timestamp.

### Step 7: Confirm completion

State what was written:
> "Retro complete. N findings. M memory files written. Audit log updated."

## Assertive vs Gated Quick Reference

| Change | Behavior |
|---|---|
| Write/update memory file | Automatic |
| Update existing settings rule | Automatic |
| Add known hook type already in settings | Automatic |
| Create new skill file | **Requires approval** |
| Edit any skill file | **Requires approval** |
| Delete or override existing rule/memory | **Requires approval** |
| Add new hook event type not in settings | **Requires approval** |

## Red Flags

| If you're about to do this | Stop. Do this instead. |
|---|---|
| "I'll note these findings" without writing files | Write the memory files now |
| Write findings to a markdown doc in the project | Write to `~/.claude/projects/.../memory/` |
| "Should I proceed?" for assertive changes | No approval needed — just do them |
| Treat all findings as equal priority | Run the triage in Step 2 |
| Skip the audit log | Always write it — it's the cross-session trend record |
| Edit a skill file without asking | Ask first — skill mutations are gated |
| Write a "Summary of what I did" as the final output | Confirm with "Retro complete. N findings..." |
