---
name: tech-astro-oom-shared-box
title: Astro check/build OOM-killed on the shared 16GB box
description: Full astro check/build gets SIGKILL (exit 137) when other sessions are active — verify with lighter gates and let CI decide
type: tech
category: workflow
tags: [tech, astro, dashboard, oom, verification, agentstate]
aliases: []
related: ["[[project-agentstate]]", "[[feedback-main-ci-green-fast]]"]
sources: []
created: 2026-10-03
updated: 2026-10-03
timestamp: 2026-10-03T00:00:00Z
---

On the duet-ubuntu box (16 GB shared across many concurrent
agent sessions), `astro check` and `astro build` for a large
Astro dashboard (200+ files) get SIGKILLed (exit 137) partway
through — even run alone — when sibling sessions hold most of
memory (`free -m` shows ~1 GB available).

**Why:** the box is shared; heavy TypeScript/Astro tooling is
the first casualty of memory pressure, and a killed build says
nothing about the code.

**How to apply:** verify with the lighter gates — `bunx biome
check <files>`, `bun test src/lib`, and a targeted
`bunx tsc -p <temp tsconfig>` over just the touched files'
import graph (expect pre-existing `ImportMeta.env` hits —
those come from astro's generated env types, not your code).
Treat CI (GitHub runners) as the authority for
check/build; don't burn retries re-running the OOM-killed
commands locally.
