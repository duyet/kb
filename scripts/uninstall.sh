#!/usr/bin/env bash
# Remove everything install.sh added — and only that. Removes the skill symlinks
# (only if they point into this repo), turns off the auto-sync cron if you enabled
# it, and reminds you to drop the PATH line. The repo itself is left untouched.
set -euo pipefail

KB_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_BASE="${KB_HOME:-$HOME}"

# Remove a symlink only if it resolves into KB_DIR (never touch real files).
rm_link() {
  local l="$1"
  if [ -L "$l" ]; then
    case "$(readlink "$l")" in
      "$KB_DIR"/*|"$KB_DIR") rm "$l"; echo "- unlink $l" ;;
      *) echo "  skip   $l (not ours)" ;;
    esac
  fi
}

AGENT_SKILLS_DIRS=(
  "${CLAUDE_SKILLS_DIR:-$HOME_BASE/.claude/skills}"
  "$HOME_BASE/.agents/skills"
  "$HOME_BASE/.codex/skills"
  "$HOME_BASE/.config/opencode/skills"
  "$HOME_BASE/.gemini/antigravity-cli/skills"
  "$HOME_BASE/.gemini/skills"
  "$HOME_BASE/.hermes/skills"
)
shopt -s nullglob
for dir in "${AGENT_SKILLS_DIRS[@]}"; do
  [ -d "$dir" ] || continue
  for s in "$KB_DIR"/skills/*/; do
    rm_link "$dir/$(basename "$s")"
  done
done
shopt -u nullglob

# hermes-native skill link.
rm_link "$HOME_BASE/.hermes/skills/kb"

# Drop the legacy CLI symlink from older installs, if present.
rm_link "${BIN_DIR:-$HOME/.local/bin}/kb"

# Remove the wired-in reflex block from global agent config.
KB_DIR="$KB_DIR" "$KB_DIR/scripts/wire.sh" off 2>/dev/null | sed 's/^/- /' || true

# Turn off auto-sync cron if it was enabled.
"$KB_DIR/bin/kb" autosync off >/dev/null 2>&1 || true
echo "- autosync off"

# Show a tidy ~/kb path in the hint if it resolves to this repo.
BIN_HINT="$KB_DIR/bin"
if [ -d "$HOME/kb" ] && [ "$(cd -P "$HOME/kb" 2>/dev/null && pwd)" = "$KB_DIR" ]; then
  BIN_HINT="\$HOME/kb/bin"
fi
echo
echo "removed. If you added it, drop this line from your shell rc:"
echo "    export PATH=\"$BIN_HINT:\$PATH\""
echo "the repo is untouched at $KB_DIR (delete it manually if you want it gone)."
