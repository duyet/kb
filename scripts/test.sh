#!/usr/bin/env bash
# Self-test: install → verify → autosync → uninstall, fully isolated.
# Clones THIS repo into a temp dir, uses a temp skills dir, and snapshots/restores
# your real crontab — so it never touches ~/kb, ~/.claude/skills, or your cron.
# Portable across macOS (bash 3.2) and Linux. No hardcoded paths.
set -uo pipefail

SRC="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP="$(mktemp -d)"
export KB_DIR="$TMP/kb"
export CLAUDE_SKILLS_DIR="$TMP/skills"
export KB_HOME="$TMP/home"              # isolate global-config wiring from your real $HOME
mkdir -p "$KB_HOME/.config/opencode" "$KB_HOME/.hermes"   # exercise opencode + hermes targets
CRON_BAK="$(crontab -l 2>/dev/null || true)"
pass=0; fail=0
ok() { echo "  ok   $1"; pass=$((pass+1)); }
no() { echo "  FAIL $1"; fail=$((fail+1)); }

cleanup() {
  if [ -n "$CRON_BAK" ]; then printf '%s\n' "$CRON_BAK" | crontab - 2>/dev/null || true
  else crontab -r 2>/dev/null || true; fi
  rm -rf "$TMP"
}
trap cleanup EXIT

KB="$KB_DIR/bin/kb"
git clone -q "$SRC" "$KB_DIR"

echo "[install]"
"$KB_DIR/scripts/install.sh" >/dev/null
[ -L "$CLAUDE_SKILLS_DIR/kb-memory" ] && [ -L "$CLAUDE_SKILLS_DIR/kb-dream" ] \
  && ok "skills linked" || no "skills linked"
grep -q "kb:start" "$KB_HOME/.claude/CLAUDE.md" 2>/dev/null \
  && grep -q "kb:start" "$KB_HOME/.config/opencode/AGENTS.md" 2>/dev/null \
  && grep -q "kb:start" "$KB_HOME/.hermes/SOUL.md" 2>/dev/null \
  && ok "config wired (claude+opencode+hermes)" || no "config wired"

echo "[verify]"
[ "$("$KB" root)" = "$KB_DIR" ] && ok "kb root = KB_DIR" || no "kb root = KB_DIR"
"$KB" lint >/dev/null 2>&1 && ok "kb lint" || no "kb lint"
"$KB" capture "selftest marker" >/dev/null \
  && tail -1 "$KB_DIR/raw/inbox/$(date +%F).md" | grep -q "selftest marker" \
  && ok "kb capture" || no "kb capture"
"$KB" index | grep -q "Memory Index" && ok "kb index" || no "kb index"

echo "[autosync]"
if command -v crontab >/dev/null 2>&1; then
  "$KB" autosync on  >/dev/null; [ "$("$KB" autosync status)" = on ]  && ok "autosync on"  || no "autosync on"
  "$KB" autosync off >/dev/null; [ "$("$KB" autosync status)" = off ] && ok "autosync off" || no "autosync off"
else echo "  skip crontab absent"; fi

echo "[uninstall]"
"$KB_DIR/scripts/uninstall.sh" >/dev/null
[ ! -e "$CLAUDE_SKILLS_DIR/kb-memory" ] && [ ! -e "$CLAUDE_SKILLS_DIR/kb-dream" ] \
  && ok "skills unlinked" || no "skills unlinked"
grep -q "kb:start" "$KB_HOME/.claude/CLAUDE.md" 2>/dev/null \
  && no "config unwired" || ok "config unwired"
[ -d "$KB_DIR/.git" ] && ok "repo intact" || no "repo intact"

echo
echo "result: $pass passed, $fail failed"
[ "$fail" -eq 0 ]
