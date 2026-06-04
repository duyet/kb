---
name: kb-memory
description: Read and write the shared-brain knowledge base (~/kb). Use on session start to recall durable facts about the user/projects, and whenever you learn a durable, general, public fact worth persisting across sessions, tools, and repos. Also use to quick-capture rough observations to the daily inbox.
---

# kb-memory

The shared brain is a git repo of markdown notes. Location is configurable: use
`$KB_DIR` if set, else run `kb root` to resolve it (default `~/kb`). All commands
below go through the `kb` CLI (in the repo's `scripts/`, or on PATH after install).

## Read (on the way in)

Before answering anything non-trivial:
1. `kb index` — read `MEMORY.md`, the one-line-per-note index.
2. Open the `memory/*.md` notes whose hook matches the task.
3. Need fresher/deeper detail? Fetch a note's `sources:` URLs (the `…/llms.txt`).

## Write (on the way out)

- **Unsure if durable** → quick-capture: `kb capture "<rough note>"` (appends to
  `raw/inbox/<today>.md`). The dream pass distills it later.
- **Known keeper** → add a standard note in `memory/` following `memory/_TEMPLATE.md`:
  top-level frontmatter (`name` == filename, `description`, `type` ∈
  user|feedback|project|reference|tech, `tags`, `created`, `updated`; optional
  `title`/`category`/`aliases`/`related`/`sources`). Link related notes with
  `[[slug]]`. Add a one-line pointer to `MEMORY.md`.
- Then **`kb lint`** (enforce the standard) and **`kb sync`** (pull/commit/push).

## Scope

Public, durable, general facts only — this repo is public. Never store secrets,
SSH hosts, internal/confidential details. See `$KB_DIR/AGENTS.md` for the full
protocol and `kb-dream` for consolidation.
