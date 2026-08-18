---
name: feedback-main-ci-green-fast
title: Keep main CI green, fast, and performant
description: After merges and new features, verify main CI is green; do not add slow tests or extra hot-path queries
type: feedback
category: style
tags: [feedback, ci, performance]
related: ["[[feedback-working-style]]", "[[feedback-fail-loud]]", "[[project-clickhouse-monitoring]]"]
created: 2026-08-18
updated: 2026-08-18
timestamp: 2026-08-18T09:15:00Z
---

On chmonitor (and similar repos): after a merge or feature batch, **check `main` CI** (`gh run list --branch main`). Required jobs (`unit-tests`, `dashboard`) must stay green. Fix red `main` before starting unrelated work.

**How to apply:**
- Do not add tests that re-query live ClickHouse when a pure unit test suffices.
- Do not put extra system-table scans on every Insights/cron sweep if a dedicated page already owns that query — extract, share SQL, run in `Promise.all`, fail closed without blocking other collectors.
- Watch Worker/dashboard build time; a type error that only shows in `tsc --noEmit` is a required-check fail — reproduce locally before push.
- Cancelled runs on older SHAs after a fast merge train are expected; judge green on the **tip** SHA.

**Why:** stacked auto-merges cancel mid-SHA CI; tip health and hot-path query cost are what users feel.
