# kb — the shared brain

A single, plain-text knowledge base that every coding agent (Claude Code, Codex,
Hermes, OpenClaw, …) and every repo reads from and writes to. **This repo is the
root source of truth for agent memory.**

It is public. It holds general, durable, *public-facing* knowledge only — never
secrets, tokens, internal hostnames, or anything you wouldn't post on a blog.

## Why

Agents normally keep memory siloed per-tool and per-project. That knowledge
evaporates between sessions and never crosses tools. This repo is the opposite:
one shared, version-controlled brain. Write a fact once, every agent on every
device can use it.

## Design philosophy

Keep it simple and hackable, following the Zettelkasten method:

- **Plain markdown, no database.** An agent can `grep`/`glob` the whole thing.
- **Atomic notes.** One fact per file under `memory/`. Small, composable, linkable.
- **Index-first.** `MEMORY.md` is a table of contents loaded *before* anything
  else, so agents pull only the few files they need into context.
- **Linked & visual.** Notes connect via `[[wikilinks]]` and `tags`, so the whole
  brain is browsable as a graph in Obsidian (this repo lives in the vault).
- **Self-healing.** A periodic "dream" pass (see `DREAM.md`) compacts, dedupes,
  and re-files notes so retrieval stays sharp as the KB grows.

## Structure

```
kb/
├── README.md     ← you are here (human onboarding)
├── AGENTS.md     ← canonical protocol for ALL agents (read/write/dream rules)
├── CLAUDE.md     ← thin pointer to AGENTS.md for Claude Code
├── DREAM.md      ← the memory-consolidation ("dream") protocol
├── MEMORY.md     ← master index, one line per memory — load this first
├── raw/          ← Layer 1: capture inbox + ground-truth sources
│   └── inbox/          daily quick-captures (dream distills → memory/, then clears)
├── memory/       ← Layer 2: agent-managed notes, one fact per file
│   ├── _TEMPLATE.md    the standard every note follows
│   ├── user-*.md       who the user is (public profile, stack, web presence)
│   ├── feedback-*.md   how agents should work (style, corrections)
│   ├── project-*.md    durable context about ongoing work
│   ├── reference-*.md  pointers to external resources
│   └── tech-*.md       reusable technical knowledge
├── scripts/      ← sync.sh (pull/commit/push), lint.sh (enforce the standard)
└── .agent/       ← agent scratchpad (state.json: ingested files + tasks)
```

Every note follows `memory/_TEMPLATE.md` and must pass `scripts/lint.sh` (required
frontmatter, `name` == filename, links resolve). See `AGENTS.md` for the format.

### Reference: Karpathy's LLM-Wiki model

This repo follows Andrej Karpathy's three-layer LLM-Wiki pattern — *the note app
is the IDE, the LLM is the programmer, the wiki is the codebase*:

| Layer | Karpathy | Here |
|-------|----------|------|
| 1 — Raw sources (immutable, read-only) | `raw/` | `raw/` |
| 2 — Synthesized, interlinked notes (AI writes) | `wiki/` | `memory/` + `MEMORY.md` |
| 3 — Schema/config (rules for the AI) | `CLAUDE.md` | `AGENTS.md` (+ `CLAUDE.md`) |

Agents read `raw/`, synthesize linked notes into `memory/`, and follow the rules
in `AGENTS.md`. `.agent/state.json` tracks what's been ingested.

## How to use

**Reading.** Start every session by reading `MEMORY.md`, then open only the
notes whose one-line description is relevant to the task.

**Writing.** When you learn something durable, general, and public, add an atomic
note to `memory/` and a one-line pointer to `MEMORY.md`. Update an existing note
rather than duplicating. Full rules in `AGENTS.md`.

**Dreaming.** Periodically (or via `/loop`), run the consolidation pass in
`DREAM.md` to keep the KB compact and well-organized.

## Install on a new machine

One command clones the repo and installs the `kb` CLI + skills + auto-sync:

```bash
curl -fsSL https://raw.githubusercontent.com/duyet/kb/main/scripts/bootstrap.sh | bash
```

Or step by step:

```bash
git clone git@github.com:duyet/kb.git ~/kb   # or KB_REPO=https://… for no-SSH
~/kb/scripts/install.sh                       # symlink CLI + skills, add cron
```

`bootstrap.sh` / `install.sh` are **machine-agnostic** — they self-locate the
repo and use `$HOME`. Configurable env: `KB_DIR` (repo location, default `~/kb`),
`KB_REPO` (clone URL), `KB_NO_CRON=1` (skip auto-sync cron), `BIN_DIR`,
`CLAUDE_SKILLS_DIR`. After install, point your agent config at it (one-time):
`~/.claude/CLAUDE.md` and `~/.claude/AGENTS.md` already reference `~/kb`.

Verify: `kb root && kb index`.

## CLI & skills

```bash
kb capture "rough note"   # → raw/inbox/<today>.md  (dream distills it later)
kb ingest <file>          # add a source doc to raw/
kb index                  # print MEMORY.md
kb lint                   # validate notes against the standard
kb sync                   # pull + commit + push
kb dream                  # how to run consolidation
```

Skills (installed to `~/.claude/skills/`, usable by Claude Code & others):
`kb-memory` (read/write protocol) and `kb-dream` (consolidation). Both resolve
the KB location from `$KB_DIR` / `kb root`, so they work wherever kb is cloned.

## Auto-sync

`scripts/sync.sh` keeps each machine and the `duyet/kb` remote in sync: pull
(rebase + autostash) → commit local edits → push. `install.sh` adds a `*/15 min`
cron for it on every machine (opt out with `KB_NO_CRON=1`). Agents should also
`kb sync` at the end of any session where they wrote a note.

## Scope

Public, general, durable knowledge. **Not** stored here: API keys, passwords,
SSH hosts, internal/employer-confidential project details, anything user-private.
Repo-specific or sensitive memory stays in that repo's local kb or the agent's
private per-project memory.
