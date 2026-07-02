#!/usr/bin/env bash
# Lint memory notes against the standard (AGENTS.md §2).
# Checks: required frontmatter fields, name == filename, no nested metadata:,
# filename <type>- prefix, MEMORY.md index coverage, every [[wikilink]] resolves,
# and a security/PII leak scan (AGENTS.md §3). Exits non-zero on any failure.
# Files prefixed with "_" (e.g. _TEMPLATE.md) are skipped.
set -euo pipefail

REPO="${KB_DIR:-$HOME/kb}"
cd "$REPO"
# `timestamp` (ISO 8601) is required by our lint — stricter than the OKF spec
# (which only mandates `type`), matching Google's reference validator, which
# rejects a concept missing type/title/description/timestamp.
REQUIRED=(name description type tags created updated timestamp)
# Valid filename type-prefix tokens (AGENTS.md §File naming). The prefix marks the
# note's group/type in the path; topic notes use `tech-` even when type: reference.
VALID_PREFIXES=" user feedback project reference tech "
fail=0

# Recursive discovery: notes now live under memory/<group>/[…]/<slug>.md.
# Skip the OKF reserved filenames (index.md, log.md) and the _TEMPLATE.
notes=()
while IFS= read -r f; do
  b="$(basename "$f")"
  [[ "$b" == _* ]] && continue
  [[ "$b" == "index.md" || "$b" == "log.md" ]] && continue
  notes+=("$f")
done < <(find memory -type f -name '*.md' | sort)

# Build the set of valid note slugs (for link resolution).
slugs=" "
for f in "${notes[@]}"; do slugs+="$(basename "$f" .md) "; done

for f in "${notes[@]}"; do
  stem="$(basename "$f" .md)"
  fm="$(awk 'NR==1&&$0=="---"{f=1;next} f&&$0=="---"{exit} f{print}' "$f")"

  for key in "${REQUIRED[@]}"; do
    grep -qE "^${key}:" <<<"$fm" || { echo "✗ $f: missing '$key:'"; fail=1; }
  done

  name="$(grep -E '^name:' <<<"$fm" | head -1 | sed 's/^name:[[:space:]]*//;s/[[:space:]]*$//')"
  [[ "$name" == "$stem" ]] || { echo "✗ $f: name ('$name') != filename ('$stem')"; fail=1; }

  # Filename convention: basename must start with a valid <type>- prefix.
  prefix="${stem%%-*}"
  [[ "$VALID_PREFIXES" == *" $prefix "* ]] || { echo "✗ $f: filename must start with a valid type prefix (user-|feedback-|project-|reference-|tech-)"; fail=1; }

  grep -qE '^metadata:' <<<"$fm" && { echo "✗ $f: nested 'metadata:' block — use top-level fields"; fail=1; }

  type="$(grep -E '^type:' <<<"$fm" | head -1 | sed 's/^type:[[:space:]]*//;s/[[:space:]]*$//')"
  case "$type" in user|feedback|project|reference|tech) ;; *) echo "✗ $f: invalid type '$type'"; fail=1 ;; esac
done

# Index coverage: MEMORY.md must carry a pointer to every note, and every
# MEMORY.md pointer must resolve to a real file (AGENTS.md §2 "Index").
INDEX="MEMORY.md"
for f in "${notes[@]}"; do
  grep -qF "($f)" "$INDEX" || { echo "✗ $f: no pointer line in $INDEX (add one under the right section)"; fail=1; }
done
while IFS= read -r p; do
  [[ -z "$p" ]] && continue
  [[ -f "$p" ]] || { echo "✗ $INDEX points to missing file: $p"; fail=1; }
done < <(grep -oE '\(memory/[^)]+\.md\)' "$INDEX" | tr -d '()')

# Broken-link check across all notes.
while read -r target; do
  [[ -z "$target" ]] && continue
  [[ "$slugs" == *" $target "* ]] || { echo "✗ broken link: [[$target]] has no note (stub — create it or fix)"; fail=1; }
done < <(grep -rho '\[\[[^]]*\]\]' "${notes[@]}" 2>/dev/null | sed 's/\[\[//;s/\]\]//;s/|.*//' | sort -u)

# Security leak check (AGENTS.md §3 — public repo).
# Scans notes plus the always-public entry points: MEMORY.md and the raw/inbox.
scan_files=("${notes[@]}" "$INDEX")
for f in raw/inbox/*.md; do [[ -e "$f" ]] && scan_files+=("$f"); done
while IFS= read -r line; do
  [[ -z "$line" ]] && continue
  echo "✗ security: $line"
  fail=1
done < <(grep -rhE \
  '(sk-[a-zA-Z0-9]{20,}|ghp_[a-zA-Z0-9]{36}|AKIA[0-9A-Z]{16}|-----BEGIN (RSA |EC )?PRIVATE KEY-----|[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|ssh://|[a-z0-9-]+\.ts\.net|@?[a-z0-9-]+\.internal\b|[a-z0-9-]+\.lan\b|[a-z0-9-]+\.local(:[0-9]+)?\b|\.onion|password\s*[:=]|secret\s*[:=]|token\s*[:=])' \
  "${scan_files[@]}" 2>/dev/null \
  | grep -v '^---' | grep -v '^sources:' \
  | grep -vE 'cluster\.local|\.env\.local|\.conf\.local|/\.local/|\.local\.deploy')

if [[ $fail -eq 0 ]]; then echo "✓ ${#notes[@]} notes pass the standard"; else echo "lint failed"; exit 1; fi
