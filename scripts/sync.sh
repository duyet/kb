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

# Commit local changes, if any.
if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -q -m "memory: auto-sync $(date '+%Y-%m-%d %H:%M')"
fi

# Push (sets upstream on first run).
git push -u origin "$BRANCH"
