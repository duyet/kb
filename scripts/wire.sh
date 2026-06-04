#!/usr/bin/env bash
# Wire the kb reflex into the global agent config so EVERY Claude Code / Codex
# session reads the brain on start. Adds a small MARKED block to ~/.claude/CLAUDE.md
# and ~/.claude/AGENTS.md — idempotent (re-run safe), and fully removable
# (`wire.sh off` strips exactly the block, leaving the rest of your config intact).
#   wire.sh on | off    (default: on)
set -euo pipefail

KB_DIR="${KB_DIR:-$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
CFG_DIR="${CLAUDE_CFG_DIR:-$HOME/.claude}"
action="${1:-on}"

# Tidy reference: show ~/kb when it resolves to this repo, else the real path.
REF="$KB_DIR"
if [ -d "$HOME/kb" ] && [ "$(cd -P "$HOME/kb" 2>/dev/null && pwd)" = "$KB_DIR" ]; then REF="~/kb"; fi

BLOCK="<!-- kb:start (managed by kb wire; remove with: kb wire off) -->
# Knowledge Base — shared brain ($REF)
On session start, read \`$REF/MEMORY.md\` (index) and open the relevant notes; fetch a note's \`sources:\` for deeper detail.
Capture rough notes with \`kb capture \"...\"\`; write durable, public facts as notes in \`$REF/memory/\`, then \`kb sync\`.
Full protocol: \`$REF/AGENTS.md\`. Consolidate via \`$REF/DREAM.md\`. Public repo — never store secrets.
<!-- kb:end -->"

# Print $1 with any existing managed block removed.
strip_block() { [ -f "$1" ] && awk '/<!-- kb:start/{s=1} s!=1{print} /<!-- kb:end/{s=0}' "$1" || true; }

wire_one() {
  local f="$1" body
  mkdir -p "$(dirname "$f")"; touch "$f"
  body="$(strip_block "$f")"
  if [ "$action" = off ]; then
    printf '%s\n' "$body" > "$f"; echo "unwired $f"
  else
    { printf '%s\n' "$body"; printf '\n%s\n' "$BLOCK"; } > "$f"; echo "wired   $f"
  fi
}

wire_one "$CFG_DIR/CLAUDE.md"
wire_one "$CFG_DIR/AGENTS.md"
