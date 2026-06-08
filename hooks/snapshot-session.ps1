#!/usr/bin/env pwsh
# PreCompact hook: snapshot the full conversation transcript BEFORE compaction
# condenses it, so retro-quick can analyze the pre-compaction signals afterward.
#
# Reads the hook payload (JSON) from stdin, copies the transcript referenced by
# `transcript_path` into ~/.claude/retro-pending/<session_id>.jsonl, keyed by
# session_id so the post-compaction SessionStart hook can find it again.

$ErrorActionPreference = 'Stop'

try {
    $raw = [Console]::In.ReadToEnd()
    if ([string]::IsNullOrWhiteSpace($raw)) { exit 0 }

    $payload = $raw | ConvertFrom-Json
    $transcript = $payload.transcript_path
    $sessionId  = $payload.session_id

    if ([string]::IsNullOrWhiteSpace($transcript) -or
        [string]::IsNullOrWhiteSpace($sessionId)  -or
        -not (Test-Path -LiteralPath $transcript)) {
        exit 0
    }

    $pendingDir = Join-Path $HOME '.claude/retro-pending'
    if (-not (Test-Path -LiteralPath $pendingDir)) {
        New-Item -ItemType Directory -Path $pendingDir -Force | Out-Null
    }

    $dest = Join-Path $pendingDir ("{0}.jsonl" -f $sessionId)
    Copy-Item -LiteralPath $transcript -Destination $dest -Force
}
catch {
    # Never block compaction on a snapshot failure — fail open.
    exit 0
}

exit 0
