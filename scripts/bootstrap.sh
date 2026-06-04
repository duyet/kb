#!/usr/bin/env bash
# Bootstrap the kb shared brain on ANY machine: clone (or update) the repo, then
# install the `kb` CLI + skills. Idempotent — safe to re-run.
#
# One-liner (new machine):
#   curl -fsSL https://raw.githubusercontent.com/duyet/kb/main/scripts/bootstrap.sh | bash
#
# Configurable:
#   KB_DIR   where to put the repo   (default: ~/kb)
#   KB_REPO  git remote to clone     (default: git@github.com:duyet/kb.git;
#            set to https://github.com/duyet/kb.git if you have no SSH key)
set -euo pipefail

KB_DIR="${KB_DIR:-$HOME/kb}"
KB_REPO="${KB_REPO:-git@github.com:duyet/kb.git}"

if [ -d "$KB_DIR/.git" ]; then
  echo "updating existing kb at $KB_DIR"
  git -C "$KB_DIR" pull --rebase --autostash
elif [ -L "$KB_DIR" ] && [ -d "$KB_DIR/.git" ]; then
  echo "kb already linked at $KB_DIR"
else
  echo "cloning $KB_REPO -> $KB_DIR"
  git clone "$KB_REPO" "$KB_DIR"
fi

exec "$KB_DIR/scripts/install.sh"
