#!/usr/bin/env bash
# Lint memory notes against the standard (AGENTS.md §2 + §3).
# Checks:
#   - required frontmatter fields, name == filename, no nested metadata:
#   - valid type + a type-token filename prefix (type visible from the path)
#   - every [[wikilink]] resolves to a real note
#   - MEMORY.md index coverage (every note is indexed; every pointer resolves)
#   - public-repo secret/PII scan (AGENTS.md §3) over notes + raw/inbox + MEMORY.md
# Exits non-zero on failure. Files prefixed with "_" (e.g. _TEMPLATE.md) are skipped.
set -euo pipefail

REPO="${KB_DIR:-$HOME/kb}"
cd "$REPO"
# Fail fast if run from the wrong place: a missing memory/ dir would otherwise
# make `find memory` (inside a process substitution) fail silently — `set -e`
# does not propagate out of process substitution — and the script would report
# "✓ 0 notes pass" with exit 0.
if [[ ! -d memory ]]; then
  echo "✗ 'memory' directory not found in '$REPO' (set KB_DIR to the repo root)" >&2
  exit 1
fi
# `timestamp` (ISO 8601) is required by our lint — stricter than the OKF spec
# (which only mandates `type`), matching Google's reference validator, which
# rejects a concept missing type/title/description/timestamp.
REQUIRED=(name description type tags created updated timestamp)
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

  grep -qE '^metadata:' <<<"$fm" && { echo "✗ $f: nested 'metadata:' block — use top-level fields"; fail=1; }

  type="$(grep -E '^type:' <<<"$fm" | head -1 | sed 's/^type:[[:space:]]*//;s/[[:space:]]*$//')"
  case "$type" in user|feedback|project|reference|tech) ;; *) echo "✗ $f: invalid type '$type'"; fail=1 ;; esac

  # Filename must carry a type token so the kind is visible from the path
  # (AGENTS.md "File naming"). The prefix set is intentionally loose: `tech-`
  # also fronts reusable reference knowledge, and logs use `lessons-` or a
  # `YYYY-MM-DD-` session date — so this asserts a recognized token, not a
  # strict 1:1 with `type:`.
  case "$stem" in
    user-*|feedback-*|project-*|reference-*|tech-*|lessons-*) ;;
    [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-*) ;;
    *) echo "✗ $f: filename must start with a type token (user-|feedback-|project-|reference-|tech-|lessons-) or a YYYY-MM-DD- session date"; fail=1 ;;
  esac
done

# Broken-link check across all notes.
while read -r target; do
  [[ -z "$target" ]] && continue
  [[ "$slugs" == *" $target "* ]] || { echo "✗ broken link: [[$target]] has no note (stub — create it or fix)"; fail=1; }
done < <(grep -rho '\[\[[^]]*\]\]' "${notes[@]}" 2>/dev/null | sed 's/\[\[//;s/\]\]//;s/|.*//' | sort -u)

# Index coverage: every note has a pointer line in MEMORY.md, and every
# MEMORY.md pointer resolves to a real file.
if [[ -f MEMORY.md ]]; then
  for f in "${notes[@]}"; do
    grep -qF "($f)" MEMORY.md || { echo "✗ $f: no pointer line in MEMORY.md (add '[Title]($f) — hook')"; fail=1; }
  done
  while read -r p; do
    [[ -z "$p" ]] && continue
    [[ -f "$p" ]] || { echo "✗ MEMORY.md: pointer references missing file '$p'"; fail=1; }
  done < <(grep -oE 'memory/[^)]*\.md' MEMORY.md | sort -u)
fi

# Security leak check (AGENTS.md §3 — public repo). Scans notes AND the
# quick-capture inbox AND the master index, since secrets can leak anywhere.
sec_files=("${notes[@]}")
while IFS= read -r f; do sec_files+=("$f"); done < <(find raw/inbox -type f -name '*.md' 2>/dev/null | sort)
[[ -f MEMORY.md ]] && sec_files+=("MEMORY.md")

# Patterns: cloud/API keys, private keys, IPv4, ssh://, Tailscale MagicDNS
# (*.ts.net), mDNS/private DNS (.internal/.lan/.local), .onion, and
# password/secret/token assignments. `grep -inE` gives case-insensitive matching
# (catches `Password:`/`Secret:`) plus file:line context; the trailing /dev/null
# guarantees grep has an input arg so it never hangs on stdin when sec_files is
# empty. The `.local` family is deliberately broad, so legit dev-file names
# (.env.local, ~/.local/, *.cluster.local, *.conf.local) — and frontmatter/sources
# lines — are allow-listed on the trailing greps.
while IFS= read -r line; do
  [[ -z "$line" ]] && continue
  echo "✗ security: $line"
  fail=1
done < <(grep -inE \
  '(sk-[a-zA-Z0-9]{20,}|ghp_[a-zA-Z0-9]{36}|AKIA[0-9A-Z]{16}|-----BEGIN (RSA |EC )?PRIVATE KEY-----|[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|ssh://|\.ts\.net\b|\.internal\b|\.lan\b|\.local\b|\.onion|password\s*[:=]|secret\s*[:=]|token\s*[:=])' \
  "${sec_files[@]}" /dev/null 2>/dev/null \
  | grep -vE '^[^:]+:[0-9]+:(---|sources:)' \
  | grep -viE '(\.env\.local|\.local/|cluster\.local|conf\.local|secrets\.local|settings\.local)')

if [[ $fail -eq 0 ]]; then echo "✓ ${#notes[@]} notes pass the standard"; else echo "lint failed"; exit 1; fi
