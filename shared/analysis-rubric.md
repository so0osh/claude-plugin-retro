# Analysis Rubric

Shared detection guide for `retro` and `retro-quick`. Each category: what to look for, positive form (reinforce), negative form (flag/fix), output type.

---

## 1. Coding Quality

**Look for:** Code written during the session — naming consistency, unnecessary complexity, magic numbers, missing comments where WHY is non-obvious.

**Positive:** Clean diffs, consistent naming, comments only where needed.

**Negative:** Inconsistent casing, unexplained constants, overly nested logic, copy-pasted blocks.

**Output:** memory (feedback), audit

---

## 2. Best Practices

**Look for:** YAGNI/DRY violations, premature abstractions, backward-compat shims added for code just written, error handling for impossible scenarios.

**Positive:** Minimal focused changes, follows existing codebase patterns.

**Negative:** Added a helper for a one-off. Introduced an abstraction not yet needed. Added TODO cleanup comments.

**Output:** memory (feedback), settings

---

## 3. Bugs Introduced or Caught

**Look for:** Logic errors in code written this session (off-by-one, wrong condition, unhandled edge case). Also note bugs correctly identified and fixed.

**Positive:** Spotted edge case before user did. Caught null-pointer risk proactively.

**Negative:** Introduced logic error caught by user or tests.

**Output:** memory (feedback), audit

---

## 4. Security Issues

**Look for:** SQL injection, XSS, command injection in generated code. Credentials in source. Overly permissive file operations. Unvalidated external input.

**Positive:** Validated user input. Used least-privilege. Flagged a security concern before implementing.

**Negative:** Passed user input directly to a shell command. Stored a secret in a variable. Didn't sanitize external data at system boundary.

**Output:** memory (feedback), settings

---

## 5. Behavioral Drifts

**Look for:** Mid-session changes away from established patterns. Started using emojis after being told not to. Reverted to verbose responses. Stopped following a feedback memory after 10 turns.

**Positive:** Maintained consistent behavior throughout despite context growth.

**Negative:** Applied a rule for N turns then drifted back to old behavior.

**Output:** memory (feedback), settings

---

## 6. Hallucinations

**Look for:** Stated an API parameter that doesn't exist. Named a function the library doesn't have. Described a file path that isn't there. Described tool behavior incorrectly.

**Positive:** Said "I'm not sure — let me check" before stating a technical fact. Verified with Grep/Read before citing.

**Negative:** Stated a version number with confidence that was wrong. Named a non-existent config key as if it were real.

**Output:** memory (feedback), audit

---

## 7. Inaccuracies and Ambiguities

**Look for:** Imprecise descriptions open to multiple interpretations. Partially correct explanations. Confused similar concepts (e.g., settings.json vs settings.local.json).

**Positive:** Explicitly disambiguated when two meanings were possible. Stated uncertainty clearly.

**Negative:** Said "the function returns the user" when it returns a user ID. Left an ambiguous statement uncorrected after user confusion.

**Output:** memory (feedback), audit

---

## 8. Intent Misinterpretations

**Look for:** User asked X, Claude did Y. User had to correct or re-clarify. Patterns in which request types get misread (e.g., always interpreting "fix" as "rewrite").

**Positive:** Asked a clarifying question before a large action when intent was ambiguous.

**Negative:** Proceeded with significant work based on a misread request. Made user repeat themselves.

**Output:** memory (feedback), audit

---

## 9. Good / Bad Decisions

**Look for:** Architectural choices, when to ask vs proceed, approach selections, tool choices. Were they well-reasoned with trade-offs considered?

**Positive:** Explained trade-offs before choosing. Chose the simpler approach. Asked before a destructive operation.

**Negative:** Chose a complex approach when a simple one was available. Proceeded with a risky action without confirming.

**Output:** memory (feedback), audit

---

## 10. Guesses vs Educated Grounded Truths

**Look for:** Uncertain statements phrased as facts. "Probably", "I think", "likely" used but presented with false confidence. Conclusions drawn without verifying premise.

**Positive:** Clearly marked uncertain statements. Read a file before citing its contents. Searched before claiming something doesn't exist.

**Negative:** Said "the config is in settings.json" without checking. Stated a behavior as certain that was actually inferred.

**Output:** memory (feedback), audit

---

## 11. Scope Creep

**Look for:** Code changed beyond what was requested. Features added that weren't asked for. Surrounding code refactored while fixing a bug. Error handling added for impossible scenarios.

**Positive:** Made only the requested change. Left surrounding code untouched unless directly relevant.

**Negative:** Fixed a bug and "while I'm here" refactored three other functions. Added a helper that wasn't needed yet.

**Output:** memory (feedback), settings

---

## 12. Tool Misuse

**Look for:** Used Bash with grep when Grep tool was available. Used Agent for a targeted lookup Glob could handle. Spawned subagent unnecessarily. Used Read when Grep would find the symbol faster.

**Positive:** Chose right tool unprompted — Grep over Bash, Edit over Write, direct tool over Agent.

**Negative:** Used `find` in Bash instead of Glob. Ran `cat` instead of Read. Spawned an Agent for a one-liner search.

**Output:** memory (feedback), settings

---

## 13. Confirmation Bias

**Look for:** Agreed with a user assumption without checking. Didn't push back on a technically incorrect assertion. Validated a bad idea to avoid friction.

**Positive:** Pushed back with reasoning when user proposed something incorrect. Offered alternative when user's approach had a flaw.

**Negative:** Agreed with "this function always returns true" without verifying. Implemented bad architecture because user seemed confident.

**Output:** memory (feedback), audit

---

## 14. Verbosity Drift

**Look for:** Responses gradually getting longer. Trailing summaries added after changes. Explaining WHAT code does instead of just writing it. Repeating context the user can already see.

**Positive:** Short direct responses. No trailing "Summary of changes" blocks after edits.

**Negative:** Ended 5 consecutive responses with a summary block. Explained what a renamed variable does.

**Output:** memory (feedback), settings

---

## 15. Memory Staleness

**Look for:** Recalled a memory, acted on it, and it contradicted current code state. Applied an outdated rule. Named a file or function that no longer exists.

**Positive:** Verified a memory against current file state before acting on it. Updated a stale memory when contradiction was found.

**Negative:** Followed a memory saying "use X pattern" without checking if X still exists. Recommended a function that was removed two sessions ago.

**Output:** memory (update the stale memory), audit

---

## 16. Permission Over-reach

**Look for:** Used permissions broader than the task required. Wrote to files outside project directory. Used destructive git commands without confirming. Accessed settings when only code files were relevant.

**Positive:** Asked before destructive operations. Used narrowest permission needed. Stayed within project scope.

**Negative:** Ran `git reset --hard` without confirming. Wrote to `~/.claude/settings.json` when only a project file needed changing.

**Output:** settings (tighten if pattern), audit

---

## 17. Positive Patterns to Reinforce

**Look for:** Non-obvious correct behaviors worth encoding as habits. Pushed back on bad assumption. Used right tool unprompted. Asked before destructive action. Verified a fact before stating it.

**Positive:** Any instance where Claude demonstrated good judgment, restraint, or quality that should be repeated.

**Negative:** N/A — this category is reinforcement only.

**Output:** memory (feedback — what to keep doing), retro-owned skill update if pattern is systemic
