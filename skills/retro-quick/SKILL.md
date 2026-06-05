---
name: retro-quick
description: Use when pre-compaction hook fires or context compression is about to happen, to capture ephemeral session signals before they are lost. Fast, non-interactive, write-only.
---

# retro-quick — Pre-Compaction Signal Capture

## Overview

Lightweight automated capture of high-value session signals before context compaction erases them. No analysis, no triage, no user interaction — write memory files and log, then stop.

## When Invoked

Triggered by the `PreCompact` hook before context compression. Do NOT invoke manually — use `/retro` for deliberate retrospectives.

## CRITICAL: This is a write task, not a conversation task

Do NOT describe what you would save. Do NOT ask for confirmation. DO write the files immediately.

## CRITICAL: Write to the memory system, not a project file

**WRONG:** Writing to `session-notes.md`, `notes.md`, or any file in the project directory.

**RIGHT:** Writing to `~/.claude/projects/<project-path>/memory/` using the memory frontmatter format.

The memory path on Windows resolves to `C:\Users\<user>\.claude\projects\<encoded-project-path>\memory\`.

## Process

Run all four steps immediately, in order, without interruption or user interaction.

### Step 1: Identify ephemeral signals

Scan the current session for signals that will NOT survive compaction:

- Explicit corrections the user gave you ("don't do X", "I meant Y")
- Decisions made and their reasons ("chose A because B")
- Hallucinations or inaccuracies you or the user caught
- Intent clarifications ("I meant X, not Y")
- Mid-session direction changes (scope narrowed, approach pivoted)
- User preferences revealed by reaction (praise, frustration, correction)

**Do NOT capture:**
- Code you wrote (it's in files)
- Completed tasks (in git or task list)
- Things already in existing memory files (check MEMORY.md first)

### Step 2: Write memory files

For EACH signal, write or update the appropriate file at:
`~/.claude/projects/<project-path>/memory/`

The `<project-path>` is the encoded form of the working directory path (e.g., `C--repos-self-impro`). Check what memory directory exists by looking at `~/.claude/projects/`.

Use this exact frontmatter format:

```markdown
---
name: <kebab-case-slug>
description: <one-line summary — specific enough to decide relevance at a glance>
metadata:
  type: feedback | user | project | reference
---

<content — lead with the fact, then **Why:** and **How to apply:** lines for feedback/project types>
```

Check `MEMORY.md` in that directory first — update an existing memory entry rather than creating a duplicate. If you update a memory, also update its entry in MEMORY.md.

### Step 3: Append to audit log

Prepend this block to `~/.claude/retro-log.md` (create file if it doesn't exist, put new entries at the TOP):

```markdown
### YYYY-MM-DD HH:MM — Pre-Compaction Quick Capture

**Session:** <absolute working directory path>
- <signal captured and what memory was written>
- <signal captured and what memory was written>
- <N> memory file(s) written
```

Replace YYYY-MM-DD HH:MM with the actual current timestamp.

### Step 4: Stop

Do not perform full analysis, settings mutations, or structural changes. Those belong to `/retro`.

## Red Flags — Wrong Actions

| If you're about to do this | Stop. Do this instead. |
|---|---|
| Write a `session-notes.md` file | Write a memory file in `~/.claude/projects/.../memory/` |
| Write to any project directory file | Write to the memory system |
| "I'll note this for later" without writing | Write the memory file now |
| "I should ask the user first" | This is automatic and non-interactive — just write |
| "There's nothing to capture" | Check all signal types in Step 1 before concluding this |
| Describe what you saved without writing files | Use the Write tool to actually write the files |
