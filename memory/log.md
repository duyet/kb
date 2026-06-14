# Directory Update Log

## 2026-06-15

- **Migration**: Restructured `memory/` into a conformant OKF v0.1 bundle — notes
  moved into nested topic dirs (`user/`, `feedback/`, `reference/`,
  `projects/[homelab/]`, `topics/{cloudflare,llm-agents,web,ci,workflow,standards}/`),
  reserved `index.md`/`log.md` added, ISO-8601 `timestamp` backfilled on every
  concept. Added `scripts/okf_gen.py` (regenerates `index.md` files + `viz.html`)
  and the self-contained `viz.html` graph viewer.
- **Fix**: Flattened two notes' nested `metadata:` blocks into top-level
  frontmatter (`project-infra-optimization`, `project-self-driven-homelab`) so they
  pass lint; backfilled `timestamp` repo-wide.
- **Docs**: `lint.sh` now recurses `memory/**/*.md`, skips reserved filenames, and
  requires `timestamp` (stricter than the OKF spec — matches Google's reference
  validator).
- **Consolidation**: dream pass distilled the 2026-06-10 inbox capture (trivy-action
  supply-chain compromise) into
  `topics/ci/tech-supply-chain-pin-github-actions.md`; cleared the inbox;
  regenerated all `index.md` + `viz.html` via `kb gen`. Bundle now 32 concepts.
