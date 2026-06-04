#!/usr/bin/env bash
# Wire the kb reflex into global agent config so EVERY session (Claude Code,
# Codex, opencode) reads the brain on start. Adds a small MARKED block to each
# tool's global instruction file — idempotent (re-run safe) and fully removable
# (`wire.sh off` strips exactly the block, leaving the rest of the file intact).
#   wire.sh on | off    (default: on)
set -euo pipefail

KB_DIR="${KB_DIR:-$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
HOME_BASE="${KB_HOME:-$HOME}"          # override in tests for isolation
action="${1:-on}"

# Tidy reference: ~/kb when it resolves to this repo, else the real path.
REF="$KB_DIR"
if [ -d "$HOME/kb" ] && [ "$(cd -P "$HOME/kb" 2>/dev/null && pwd)" = "$KB_DIR" ]; then REF="~/kb"; fi

# Targets: always wire Claude Code (.claude); wire other agents only if present.
# Each agent's global, always-loaded instruction file:
targets=( "$HOME_BASE/.claude/CLAUDE.md" "$HOME_BASE/.claude/AGENTS.md" )
[ -d "$HOME_BASE/.codex" ]           && targets+=( "$HOME_BASE/.codex/AGENTS.md" )
[ -d "$HOME_BASE/.config/opencode" ] && targets+=( "$HOME_BASE/.config/opencode/AGENTS.md" )
[ -d "$HOME_BASE/.hermes" ]          && targets+=( "$HOME_BASE/.hermes/SOUL.md" )      # hermes (loaded each msg)
[ -d "$HOME_BASE/.openclaw" ]        && targets+=( "$HOME_BASE/.openclaw/CLAUDE.md" )

BLOCK="<!-- kb:start (managed by kb wire; remove with: kb wire off) -->
# Knowledge Base — shared brain ($REF)
On session start, read \`$REF/MEMORY.md\` (index) and open the relevant notes; fetch a note's \`sources:\` for deeper detail.
Capture rough notes with \`kb capture \"...\"\`; write durable, public facts as notes in \`$REF/memory/\`, then \`kb sync\`.
Full protocol: \`$REF/AGENTS.md\`. Consolidate via \`$REF/DREAM.md\`. Public repo — never store secrets.
<!-- kb:end -->"

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

for t in "${targets[@]}"; do wire_one "$t"; done
