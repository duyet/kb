---
name: tech-okf-open-knowledge-format
title: Open Knowledge Format (OKF) — the spec this KB already implements
description: OKF v0.1 (Google, 2026-06) formalizes the markdown+frontmatter "LLM-wiki" pattern this repo already uses; this repo is conformant, missing only an ISO-8601 timestamp
type: tech
category: standards
tags: [tech, okf, knowledge-format, llm-agents, docs-driven, spec]
aliases: [OKF, open-knowledge-format]
related: ["[[feedback-docs-driven-development]]", "[[project-kb-duyet-net]]", "[[tech-ai-agent-stack]]"]
sources: ["https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md", "https://cloud.google.com/blog/products/data-analytics/how-the-open-knowledge-format-can-improve-data-sharing"]
created: 2026-06-14
updated: 2026-06-14
timestamp: 2026-06-14T00:00:00Z
---

**Open Knowledge Format (OKF) v0.1** — Draft. Published by Google Cloud (Sam
McVeety, Amir Hormati) 2026-06-13. Canonical spec: `GoogleCloudPlatform/knowledge-catalog/okf/SPEC.md`.

An open, vendor-neutral standard for the **markdown + YAML-frontmatter
"LLM-wiki"** pattern — the same pattern [[feedback-docs-driven-development]] and
this repo already use. "Just markdown, just files, just YAML frontmatter." No
runtime, no SDK, no compression.

## Shape

- **Bundle** = a directory tree of `.md` files. **Concept** = one `.md` file.
  **Concept ID** = the file path with `.md` removed (the *path is the identity*).
- **Reserved filenames** (MUST NOT be concepts): `index.md` (directory listing
  for progressive disclosure), `log.md` (chronological change history, newest
  first, ISO 8601).
- Concepts link via **standard markdown links** (bundle-relative `/x.md` or
  relative `x.md`) → a graph richer than the folder hierarchy. Consumers MUST
  tolerate broken links.
- **Frontmatter — REQUIRED: only `type`** (free-form string, not centrally
  registered; e.g. `BigQuery Table`, `Metric`, `Playbook`, `Reference`).
  Recommended: `title`, `description`, `resource` (URI of the asset), `tags`,
  `timestamp` (ISO 8601). Producers MAY add custom keys; **consumers MUST
  preserve unknown fields** and tolerate unknown `type`s.
- Conventional body headings: `# Schema`, `# Examples`, `# Citations`.

## Three design principles

1. **Minimally opinionated** — only `type` is mandated; spec defines the
   *interoperability surface*, not the content model.
2. **Producer/consumer independence** — the format is the contract; tooling at
   each end is swappable (human-authored ↔ agent-consumed).
3. **Format, not platform** — no cloud / DB / model / agent-framework lock-in.

## Gotcha: the reference validator is stricter than the prose

The prose requires only `type`, but Google's reference `OKFDocument.validate()`
rejects any doc missing **`type`, `title`, `description`, `timestamp`** (all four,
non-empty), and Google's own sample bundles (GA4, Stack Overflow, Bitcoin) carry
all four. So *de facto* OKF = those 4 fields. Reference tooling: a BigQuery
enrichment agent (producer) + a self-contained static HTML graph visualizer
(consumer).

## How this repo aligns

This repo is **already an OKF bundle** by the prose spec — `memory/*.md` are
concept docs, each carrying `type`. Field map:

| OKF field | this repo | status |
|-----------|-----------|--------|
| `type` | `type` (user/feedback/project/reference/tech) | ✅ |
| `title` | `title` | ✅ |
| `description` | `description` | ✅ |
| `tags` | `tags` | ✅ |
| `resource` | `sources` (array of URLs vs singular URI) | ≈ |
| `timestamp` | `created` / `updated` — **date-only, not ISO 8601 datetime** | ⚠️ |
| path = ID | `name:` field (== filename) — a permitted custom key | ✅ (extension) |
| `index.md` | `MEMORY.md` (root, custom name) | ≈ |
| `log.md` | — | ❌ (none yet) |

**Only strict gap:** no ISO 8601 `timestamp` (e.g. `2026-06-14T14:30:00Z`). Adding
it makes this repo pass the reference validator. `[[wikilinks]]` are an
OKF-compatible custom convention (Obsidian also resolves standard md links).
The monorepo `apps/kb` app is a live **consumer** of this bundle — see
[[project-kb-duyet-net]].

**How to apply:** add an ISO 8601 `timestamp` to the template + new notes;
keep `[[wikilinks]]` (Obsidian-native) — do NOT rewrite to plain md links (would
break the graph + lint + skills). The repo's dynamic-frontmatter consumers make
the addition non-breaking.
