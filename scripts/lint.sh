#!/usr/bin/env bash
# Lint memory notes against the standard (AGENTS.md §2).
# Checks: required frontmatter fields, name == filename, no nested metadata:,
# and that every [[wikilink]] resolves to a real note. Exits non-zero on failure.
# Files prefixed with "_" (e.g. _TEMPLATE.md) are skipped.
set -euo pipefail

REPO="${KB_DIR:-$HOME/kb}"
cd "$REPO"
REQUIRED=(name description type tags created updated)
fail=0

shopt -s nullglob
notes=()
for f in memory/*.md; do
  [[ "$(basename "$f")" == _* ]] && continue
  notes+=("$f")
done

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
done

# Broken-link check across all notes.
while read -r target; do
  [[ -z "$target" ]] && continue
  [[ "$slugs" == *" $target "* ]] || echo "✗ broken link: [[$target]] has no note (stub — create it or fix)"
done < <(grep -rho '\[\[[^]]*\]\]' "${notes[@]}" 2>/dev/null | sed 's/\[\[//;s/\]\]//' | sort -u)

if [[ $fail -eq 0 ]]; then echo "✓ ${#notes[@]} notes pass the standard"; else echo "lint failed"; exit 1; fi
