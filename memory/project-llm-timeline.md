---
name: project-llm-timeline
title: LLM Timeline app
description: llm-timeline.duyet.net — TanStack Start SSG timeline of LLM models 1950–2026, shadcn UI, dual data sources
type: project
category: web
tags: [project, duyet, web, llm-agents, data]
aliases: [llm-timeline]
related: ["[[project-duyet-net]]", "[[tech-flat-design-system]]", "[[tech-tanstack-start-ssg]]", "[[tech-rust-wasm-prerender]]", "[[project-duyetbot]]"]
sources: ["https://kb.duyet.net/llms.txt", "https://llm-timeline.duyet.net"]
created: 2026-06-04
updated: 2026-06-04
---

`apps/llm-timeline` ([[project-duyet-net]]) — timeline of LLM models 1950–2026,
3700+ pre-rendered pages. Reference implementation for the flat/shadcn design
(PR #1003): all `shadow-*` removed, semantic tokens only, vertical stat-card grids.

**Data** (built into pages at build time, `pnpm run sync`, no runtime API):
- Curated: ~785 models from Google Sheets, hand-maintained by Duyet (out of
  scope for [[project-duyetbot]] — research facts + citations).
- Epoch AI: ~3156 models (extended range back to 1950).
- Deduped to ~3937 unique (last sync 2026-03-25).

**Tech:** warm cream palette; `@tanstack/react-virtual` `useWindowVirtualizer`
for the scroll; WASM normalizer crate via `initSync` (kept for consistency though
not faster — see [[tech-rust-wasm-prerender]]); badge variants replace
color-lookup functions. Design conventions: [[tech-flat-design-system]].
