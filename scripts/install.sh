#!/usr/bin/env bash
# Install kb on this machine with the smallest possible footprint:
#   - link the skills into ~/.claude/skills   (the only way agents discover them)
#   - tell you the one PATH line to add for the `kb` CLI (kept in the repo)
# Nothing is copied, no cron, no edits to your shell rc or any other file.
# Reverse with uninstall.sh.
set -euo pipefail

KB_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_BASE="${KB_HOME:-$HOME}"
SKILLS_DIR="${CLAUDE_SKILLS_DIR:-$HOME_BASE/.claude/skills}"

# Link skills into every agent skills dir that exists on this machine.
AGENT_SKILLS_DIRS=(
  "${CLAUDE_SKILLS_DIR:-$HOME_BASE/.claude/skills}"
  "$HOME_BASE/.agents/skills"
)
shopt -s nullglob
for dir in "${AGENT_SKILLS_DIRS[@]}"; do
  [ -d "$dir" ] || continue
  for s in "$KB_DIR"/skills/*/; do
    name="$(basename "$s")"
    ln -sfn "${s%/}" "$dir/$name"
    echo "+ link  $dir/$name"
  done
done
shopt -u nullglob

# hermes-native skill — file-tool oriented — into hermes's own skills dir.
# Only wired if hermes is installed (dir exists).
if [ -d "$HOME_BASE/.hermes/skills" ]; then
  ln -sfn "$KB_DIR/agents/hermes/kb" "$HOME_BASE/.hermes/skills/kb"
  echo "+ link  $HOME_BASE/.hermes/skills/kb"
fi

# Wire the reflex into global agent config (Claude Code / Codex / opencode).
# Skip with KB_NO_WIRE=1.
if [ -z "${KB_NO_WIRE:-}" ]; then
  KB_DIR="$KB_DIR" "$KB_DIR/scripts/wire.sh" on | sed 's/^/  /'
fi

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
