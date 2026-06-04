#!/usr/bin/env bash
# Remove everything install.sh added — and only that. Removes the skill symlinks
# (only if they point into this repo), turns off the auto-sync cron if you enabled
# it, and reminds you to drop the PATH line. The repo itself is left untouched.
set -euo pipefail

KB_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

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

for s in "$KB_DIR"/skills/*/; do
  rm_link "$SKILLS_DIR/$(basename "$s")"
done

# Drop the legacy CLI symlink from older installs, if present.
rm_link "${BIN_DIR:-$HOME/.local/bin}/kb"

# Turn off auto-sync cron if it was enabled.
"$KB_DIR/bin/kb" autosync off >/dev/null 2>&1 || true
echo "- autosync off"

echo
echo "removed. If you added it, drop this line from your shell rc:"
echo "    export PATH=\"$KB_DIR/bin:\$PATH\""
echo "the repo is untouched at $KB_DIR (delete it manually if you want it gone)."
