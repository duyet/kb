# kb — the shared brain

A single, plain-text knowledge base that every coding agent (Claude Code, Codex,
Hermes, OpenClaw, …) and every repo reads from and writes to — the **root source
of truth for agent memory**. Write a fact once; every agent on every device uses it.

Public repo: general, durable, *public-facing* knowledge only — never secrets,
tokens, internal hosts, or anything you wouldn't post on a blog.

## Design

Simple and hackable (Zettelkasten-style): plain markdown, no database (agents
`grep` it); **atomic notes** (one fact per file); **index-first** (`MEMORY.md`
loaded before anything else); **linked** via `[[wikilinks]]` + `tags` (browsable
as a graph in Obsidian); **self-healing** via the `DREAM.md` consolidation pass.

## Structure

```
kb/
├── AGENTS.md   ← canonical protocol for ALL agents (read/write/dream rules)
├── CLAUDE.md   ← thin pointer to AGENTS.md
├── DREAM.md    ← memory-consolidation ("dream") protocol
├── MEMORY.md   ← master index, one line per note — load first
├── raw/        ← capture inbox (raw/inbox/<date>.md) + ground-truth sources
├── memory/     ← agent-managed notes (_TEMPLATE.md = the standard; user-/feedback-/
│                 project-/reference-/tech- by type)
├── skills/     ← kb-memory, kb-dream (installable Claude Code skills)
├── scripts/    ← bootstrap / install / kb CLI / sync / lint
└── .agent/     ← state.json (ingested files + tasks)
```

Every note follows `memory/_TEMPLATE.md` and must pass `kb lint`. Format spec in
`AGENTS.md`.

## How it works

- **Read in:** `kb index` (= `MEMORY.md`), open the relevant notes; fetch a note's
  `sources:` (`llms.txt`) for deeper detail.
- **Write out:** unsure it's durable → `kb capture "note"` (lands in `raw/inbox/`);
  known keeper → a standard note in `memory/`. Then `kb lint && kb sync`.
- **Dream:** periodically (or `/loop`) run `DREAM.md` — it ingests the inbox + raw
  sources into clean notes, dedupes, refreshes stale notes from `sources:`, rebuilds
  the index, and syncs.

## Install (any machine)

```bash
curl -fsSL https://raw.githubusercontent.com/duyet/kb/main/scripts/bootstrap.sh | bash
```

Minimal footprint — the only changes to your machine are **link the skills** into
`~/.claude/skills` and a **PATH line** you add for the `kb` CLI (the script stays
in the repo, nothing is copied):

```bash
export PATH="$HOME/kb/bin:$PATH"     # add to ~/.zshrc or ~/.bashrc
```

No cron, no edits to other files. Opt in to background sync with `kb autosync on`.
Remove everything with `scripts/uninstall.sh` (unlinks; repo untouched). Env:
`KB_DIR`, `KB_REPO`, `CLAUDE_SKILLS_DIR`. Verify: `kb root`.

## CLI

```bash
kb capture "rough note"   # → raw/inbox/<today>.md
kb ingest <file>          # add a source doc to raw/
kb index | kb lint | kb sync | kb dream | kb root
kb autosync on|off|status # opt-in */15min sync cron
```

Skills `kb-memory` (read/write protocol) and `kb-dream` (consolidation) install to
`~/.claude/skills/` and resolve the KB via `$KB_DIR` / `kb root`, so they work
wherever kb is cloned. They're **canonical in this repo** — install via the symlink
installer (auto-updates on `git pull`). To share a skill without shipping your
memory, mirror `skills/` into a separate plugins repo (path-agnostic via `KB_DIR`).

## Scope

Public, general, durable knowledge only. **Never** here: secrets, SSH hosts,
internal/employer-confidential details, anything user-private — those stay in a
repo's local kb or the agent's private per-project memory.
