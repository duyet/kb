---
name: feedback-docs-driven-development
title: Docs-Driven Development
description: Duyet's pattern — tiny CLAUDE.md/AGENTS.md router + a docs/kb "brain"; agents auto-read in, auto-write out
type: feedback
category: workflow
tags: [feedback, duyet, workflow, docs-driven, kb]
related: ["[[feedback-working-style]]", "[[user-duyet-profile]]"]
created: 2026-06-04
updated: 2026-06-04
---

Duyet's core agent-collaboration pattern (from his blog, "Docs-Driven Development"):

- **`CLAUDE.md`/`AGENTS.md` stays tiny** — short, stable rules + a router pointing
  at the right doc. Cramming architecture/feature contracts in there rots the file.
- **A versioned, grep-able `kb` is the brain** — structured by the question being
  asked; the same docs serve Duyet, teammates, and every coding agent.
- **Make read/write reflexive, phrased as triggers not requests:** read the index
  on the way *in* (before answering anything non-trivial), write back on the way
  *out* (before forgetting). "Remember to write docs" doesn't work — triggers do.

**Why:** rules-in-prompt evaporate between sessions; a structured external brain
persists and is reviewable in a PR.

**How to apply:** this is exactly the model this repo implements — read `MEMORY.md`
first, grep `memory/`, write durable facts back automatically. Don't bloat the
router files; put knowledge in notes.
