#!/usr/bin/env bash
# Install the kb CLI and skills globally from this repo.
# - symlinks scripts/kb       -> ~/.local/bin/kb        (on PATH)
# - symlinks skills/<name>    -> ~/.claude/skills/<name>
# KB location is auto-detected from this repo; override by exporting KB_DIR.
set -euo pipefail

KB_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"
SKILLS_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

mkdir -p "$BIN_DIR" "$SKILLS_DIR"

ln -sf "$KB_DIR/scripts/kb" "$BIN_DIR/kb"
echo "linked  $BIN_DIR/kb -> $KB_DIR/scripts/kb"

for s in "$KB_DIR"/skills/*/; do
  name="$(basename "$s")"
  ln -sfn "${s%/}" "$SKILLS_DIR/$name"
  echo "linked  $SKILLS_DIR/$name -> ${s%/}"
done

# Auto-sync cron (every 15 min). Skip with KB_NO_CRON=1. Idempotent.
if [[ -z "${KB_NO_CRON:-}" ]] && command -v crontab >/dev/null 2>&1; then
  line="*/15 * * * * $KB_DIR/scripts/sync.sh >> \$HOME/.kb-sync.log 2>&1"
  ( crontab -l 2>/dev/null | grep -vF "$KB_DIR/scripts/sync.sh"; echo "$line" ) | crontab -
  echo "cron    */15m auto-sync installed (KB_NO_CRON=1 to skip)"
fi

echo
echo "KB_DIR = $KB_DIR"
case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) echo "note: add $BIN_DIR to PATH:  export PATH=\"$BIN_DIR:\$PATH\"" ;;
esac
echo "done. Try: kb help"
