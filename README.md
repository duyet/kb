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

## Onboarding a new device or new agent

```bash
# 1. Clone to the standard location
git clone git@github.com:duyet/kb.git ~/kb

# 2. Point your global agent config at it (one-time)
#    Claude Code:  ~/.claude/CLAUDE.md   already references ~/kb
#    Codex/others: ~/.claude/AGENTS.md   (and/or ~/.codex/AGENTS.md)
#    If missing, add a line telling the agent to read ~/kb/AGENTS.md
#    on session start.

# 3. Verify
cat ~/kb/MEMORY.md     # should list the current memories
```

That's it. The agent now shares the brain.

## Auto-sync

`scripts/sync.sh` keeps this device and the `duyet/kb` remote in sync: it pulls
(rebase + autostash), commits any local edits, and pushes — safe to run anytime.

```bash
~/kb/scripts/sync.sh            # one-off sync
```

Run it on a schedule so every device stays current:

```bash
# every 15 min via cron
*/15 * * * * /Users/duet/kb/scripts/sync.sh >> ~/.kb-sync.log 2>&1
```

Agents should also sync at the end of any session where they wrote a note.

## Scope

Public, general, durable knowledge. **Not** stored here: API keys, passwords,
SSH hosts, internal/employer-confidential project details, anything user-private.
Repo-specific or sensitive memory stays in that repo's local kb or the agent's
private per-project memory.
