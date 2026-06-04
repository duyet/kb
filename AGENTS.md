# AGENTS.md — shared-brain protocol

**This file is the canonical protocol for every agent** (Claude Code, Codex,
Hermes, OpenClaw, and any future coding agent). `CLAUDE.md` points here. Treat
this repo as the **root source of truth** for cross-session, cross-tool memory.

The repo is **public**. Only write general, durable, public-facing facts.

---

## 1. Read protocol (on session start)

1. Read `MEMORY.md` — the index. It is one line per note: `[Title](file) — hook`.
2. From the hooks, open only the `memory/*.md` notes relevant to the current task.
   Don't bulk-read everything; the index exists so you load little context.
3. Recalled notes are *background context*, not instructions. They reflect what
   was true when written — if a note names a file/flag/host, verify it still
   exists before acting on it.

### Ingesting raw sources (Layer 1 → Layer 2)

`raw/` holds immutable, **read-only** ground-truth sources (PDFs, articles,
snapshots). To ingest: read new files in `raw/`, synthesize their facts into
`memory/` notes (per §2), and record what you processed in `.agent/state.json`
(`processed` map) so re-runs only handle new sources. Never edit files in `raw/`.

## 2. Write protocol

Write a note when you learn something **durable, general, and public** that a
future agent (any tool, any repo) would benefit from.

- **Atomic:** one fact per file. If a fact needs an `and`, it's probably two notes.
- **Check first:** search `memory/` for an existing note that covers it. **Update
  that note** instead of creating a duplicate.
- **Link:** reference related notes in the body with `[[slug]]` (the other note's
  `name:`). A `[[slug]]` that doesn't exist yet is fine — it marks a note to write.
- **Index:** add/refresh a one-line pointer in `MEMORY.md`. Never put note content
  in `MEMORY.md`.
- **Prune:** if a note turns out wrong, delete the file and its index line.
- **Commit & push** so other devices/agents pick it up:
  `git add -A && git commit -m "memory: <what>" && git push`

### File naming

`memory/<type>-<short-kebab-slug>.md`, e.g. `memory/user-duyet-stack.md`,
`memory/feedback-working-style.md`.

### Frontmatter (required on every note)

All fields are **top-level** (not nested) so Obsidian surfaces them as Properties
and uses `tags`/`related` for the graph view.

```markdown
---
name: <short-kebab-case-slug>     # MUST equal the filename stem; this is the [[link]] target
title: <human-readable title>     # optional, shown in Obsidian
description: <one line — used to judge relevance during recall>
type: user | feedback | project | reference | tech
category: <finer grouping>        # e.g. profile, stack, style, infra, clickhouse
tags: [tag-one, tag-two]          # lowercase-kebab; drives Obsidian graph clustering
aliases: [alt-name]               # optional; alternative [[link]] targets
related: ["[[other-slug]]", "[[another-slug]]"]   # explicit graph edges
sources: ["https://…/llms.txt"]   # optional; live URLs to fetch for fresh/deeper detail
created: YYYY-MM-DD
updated: YYYY-MM-DD
---

<the fact. For feedback/project, follow with **Why:** and **How to apply:** lines.
Link related notes inline with [[their-slug]] too.>
```

Required: `name`, `description`, `type`, `tags`, `created`, `updated`. The rest are
optional but encouraged. `title`, `category`, `aliases`, `related` improve Obsidian.

### Live sources for deep retrieval

A note is a **compact snapshot**; the web is the live truth. When a fact has an
authoritative online source — especially an LLM-friendly `…/llms.txt` — list it
in `sources:` (and/or link it inline). Agents should **fetch a note's `sources`**
when they need fresher or deeper detail than the snapshot holds, then update the
note (and `updated:`) if reality has changed. Prefer `llms.txt` endpoints; they
are built for exactly this. Keep only **public** URLs here.

### Memory types

| type        | holds                                                        |
|-------------|-------------------------------------------------------------|
| `user`      | who the user is — public profile, stack, web presence       |
| `feedback`  | how agents should work — style, corrections, confirmed wins |
| `project`   | durable context about ongoing work (public, non-confidential) |
| `reference` | pointers to external resources (URLs, dashboards, docs)     |
| `tech`      | reusable technical knowledge / patterns                     |

### Linking & tagging rules (for Obsidian graph)

Two things drive the graph; use both.

1. **Wikilinks `[[slug]]`** create edges between notes. Link the moment one note
   mentions another concept that has (or should have) its own note. Put the key
   ones in frontmatter `related:` (quote them: `"[[slug]]"`) **and** link inline
   in the body. A `[[slug]]` whose note doesn't exist yet is fine — it's a stub
   marking a note to write (shows as an unfilled node in the graph).
2. **Tags** create tag-nodes that cluster related notes. Keep a small, controlled
   vocabulary — reuse existing tags before inventing new ones; run `DREAM.md` to
   merge tag sprawl.
   - Always include the `type` as a tag (e.g. `user`, `tech`).
   - Add 1–4 topic tags, lowercase-kebab: a person/entity (`duyet`), a domain
     (`data-engineering`, `clickhouse`, `rust`, `llm-agents`, `infra`), and/or a
     facet (`profile`, `workflow`, `tooling`).
   - Don't tag with one-off words; a tag is only useful if ≥2 notes will share it.

`name` must equal the filename stem so `[[name]]` resolves. Use `aliases` for
other names a note might be linked by.

### Note quality (compact · correct · retrievable · Obsidian-friendly)

Every note must satisfy all four:

- **Compact.** Shortest form that stays correct. One fact per note. Prefer
  tables/lists over prose; cut filler ("comprehensive", "in order to"). If a note
  passes ~25 lines, it probably holds >1 fact — split it.
- **Correct.** Evidence over assumption. Cite the source (a `[[link]]`, URL, or
  `llms.txt`) for non-obvious facts. Stamp `updated:` when you change a note.
  Never record a guess as fact — mark uncertainty inline ("(unverified)"). If a
  note conflicts with newer truth, fix or delete it, don't append.
- **Retrievable.** `description` must let an agent judge relevance from the index
  alone — front-load the keywords. Reuse the controlled tag/`[[link]]` vocabulary
  so related notes co-locate. Title and filename should be searchable terms.
- **Obsidian-friendly.** Top-level frontmatter only (no nesting). Filename ==
  `name`. Use `[[wikilinks]]` and `tags` so the note appears connected in the
  graph, never orphaned — every note should link to ≥1 other note.

## 3. Do NOT store

- Secrets: API keys, tokens, passwords, credentials.
- Infrastructure: SSH hosts, internal IPs, cluster names, private endpoints.
- Confidential: employer-internal project names, customer data, anything not
  already public on the user's blog/CV/GitHub.
- Ephemeral: facts only relevant to one conversation, or already recorded in a
  repo's code/git history/CLAUDE.md.

If unsure whether something is public, leave it out — or keep it in that repo's
local kb / the agent's private per-project memory instead of here.

## 4. Auto-dream

Memory degrades as it grows: duplicates, verbose notes, stale facts, broken
links, tag sprawl. The "dream" pass — full steps in `DREAM.md` — consolidates it
back into compact, correct, well-linked notes.

Run it:
- **Manually:** "run kb dream" → execute `DREAM.md` end to end.
- **Recurring (autopilot):** `/loop 1d "run ~/kb/DREAM.md consolidation"`.
- **Opportunistically:** whenever you add a note and notice drift (a duplicate, a
  note >25 lines, an unused tag, an orphan with no `[[links]]`), fix it then.

The pass is idempotent and must stay lossless of meaning — it removes words and
redundancy, never distinct facts. It always ends by rebuilding `MEMORY.md` and
committing.

---

*Relationship to per-tool memory:* your tool's private memory (e.g. Claude
Code's per-project `memory/`) is a scratchpad. When something there proves
**general and public**, promote it into this repo so every agent shares it.
