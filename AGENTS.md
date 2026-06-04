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

```markdown
---
name: <short-kebab-case-slug>   # matches the [[slug]] used to link it
description: <one line — used to judge relevance during recall>
metadata:
  type: user | feedback | project | reference | tech
---

<the fact. For feedback/project, follow with **Why:** and **How to apply:** lines.
Link related notes with [[their-slug]].>
```

### Memory types

| type        | holds                                                        |
|-------------|-------------------------------------------------------------|
| `user`      | who the user is — public profile, stack, web presence       |
| `feedback`  | how agents should work — style, corrections, confirmed wins |
| `project`   | durable context about ongoing work (public, non-confidential) |
| `reference` | pointers to external resources (URLs, dashboards, docs)     |
| `tech`      | reusable technical knowledge / patterns                     |

## 3. Do NOT store

- Secrets: API keys, tokens, passwords, credentials.
- Infrastructure: SSH hosts, internal IPs, cluster names, private endpoints.
- Confidential: employer-internal project names, customer data, anything not
  already public on the user's blog/CV/GitHub.
- Ephemeral: facts only relevant to one conversation, or already recorded in a
  repo's code/git history/CLAUDE.md.

If unsure whether something is public, leave it out — or keep it in that repo's
local kb / the agent's private per-project memory instead of here.

## 4. Dream protocol

Memory degrades as it grows: duplicates, verbose notes, stale facts, broken
links. Periodically run the consolidation ("dream") pass defined in `DREAM.md`
to keep retrieval sharp. Trigger it manually, on a `/loop`, or whenever you
notice the KB drifting.

---

*Relationship to per-tool memory:* your tool's private memory (e.g. Claude
Code's per-project `memory/`) is a scratchpad. When something there proves
**general and public**, promote it into this repo so every agent shares it.
