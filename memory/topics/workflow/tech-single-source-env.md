---
name: tech-single-source-env
title: Single-source env config
description: One committed non-secret env file feeds client build and server runtime
type: tech
category: architecture
tags: [tech, architecture, env-config]
related: ["[[tech-one-codebase-oss-saas]]", "[[feedback-public-kb-only]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Dual sources (hand-maintained wrangler vars vs Vite `VITE_*`) drift silently. Canonical names → derive client + deploy targets.

Secrets never in committed env files. Related: [[tech-one-codebase-oss-saas]], [[feedback-public-kb-only]].
