#!/usr/bin/env bash
# Auto-sync the kb shared brain with the duyet/kb remote.
# Pulls remote changes (rebase, autostash), commits any local edits, pushes.
# Safe to run repeatedly (cron, git hook, or by hand). Never loses local work.
set -euo pipefail

REPO="${KB_DIR:-$HOME/kb}"
cd "$REPO"

BRANCH="$(git rev-parse --abbrev-ref HEAD)"

# Pull first so we rebase local work on top of any remote changes.
git pull --rebase --autostash origin "$BRANCH" || true

# Commit local changes, if any — but never commit a state that fails lint
# (standard + security checks, AGENTS.md §2/§3).
if [ -n "$(git status --porcelain)" ]; then
  if ! KB_DIR="$REPO" bash "$REPO/scripts/lint.sh"; then
    echo "✗ sync: lint failed — refusing to commit. Fix the issues above and re-run." >&2
    exit 1
  fi
  git add -A
  git commit -q -m "memory: auto-sync $(date '+%Y-%m-%d %H:%M')"
fi

# Push (sets upstream on first run).
git push -u origin "$BRANCH"
