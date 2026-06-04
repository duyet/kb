#!/usr/bin/env bash
# Install kb on this machine with the smallest possible footprint:
#   - link the skills into ~/.claude/skills   (the only way agents discover them)
#   - tell you the one PATH line to add for the `kb` CLI (kept in the repo)
# Nothing is copied, no cron, no edits to your shell rc or any other file.
# Reverse with uninstall.sh.
set -euo pipefail

KB_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

mkdir -p "$SKILLS_DIR"
shopt -s nullglob
for s in "$KB_DIR"/skills/*/; do
  name="$(basename "$s")"
  ln -sfn "${s%/}" "$SKILLS_DIR/$name"
  echo "+ link  $SKILLS_DIR/$name"
done
shopt -u nullglob

echo
echo "KB_DIR = $KB_DIR"
# Prefer a tidy ~/kb path in the hint if it resolves to this repo.
BIN_HINT="$KB_DIR/bin"
if [ -d "$HOME/kb" ] && [ "$(cd -P "$HOME/kb" 2>/dev/null && pwd)" = "$KB_DIR" ]; then
  BIN_HINT="\$HOME/kb/bin"
fi
case ":$PATH:" in
  *":$KB_DIR/bin:"*) echo "✓ kb CLI already on PATH" ;;
  *) echo "add the kb CLI to PATH (put in your ~/.zshrc or ~/.bashrc):"
     echo "    export PATH=\"$BIN_HINT:\$PATH\"" ;;
esac
echo
echo "optional auto-sync (opt-in) →  kb autosync on"
echo "uninstall                   →  $KB_DIR/scripts/uninstall.sh"
