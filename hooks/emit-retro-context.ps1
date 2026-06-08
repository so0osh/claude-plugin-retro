#!/usr/bin/env pwsh
# SessionStart hook (matcher: compact): runs AFTER compaction completes, in the
# same session. If a pre-compaction snapshot exists for this session_id, inject
# context instructing the model to invoke retro-quick against that snapshot.
#
# This is the one post-compaction hook that can reach the model: SessionStart
# supports hookSpecificOutput.additionalContext, which is added to Claude's
# context and acted on in subsequent model calls.

$ErrorActionPreference = 'Stop'

try {
    $raw = [Console]::In.ReadToEnd()
    if ([string]::IsNullOrWhiteSpace($raw)) { exit 0 }

    $payload   = $raw | ConvertFrom-Json
    $sessionId = $payload.session_id
    if ([string]::IsNullOrWhiteSpace($sessionId)) { exit 0 }

    $snapshot = Join-Path $HOME (".claude/retro-pending/{0}.jsonl" -f $sessionId)
    if (-not (Test-Path -LiteralPath $snapshot)) { exit 0 }

    $context = @"
A pre-compaction transcript snapshot was saved before this session's context was compacted.
Invoke the retro-quick skill now to capture ephemeral signals from it before continuing.
Snapshot path: $snapshot
After retro-quick finishes writing memories, delete the snapshot file.
"@

    $out = @{
        hookSpecificOutput = @{
            hookEventName   = 'SessionStart'
            additionalContext = $context
        }
    }

    $out | ConvertTo-Json -Depth 5 -Compress
}
catch {
    exit 0
}

exit 0
