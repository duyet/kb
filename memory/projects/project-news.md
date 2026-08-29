---
name: project-news
title: news.duyet.net
description: Personal news feed + public digest; homepage AI;DR thumbs; news-tab own 0.1.x release line
type: project
category: web
tags: [project, duyet, web]
related: ["[[project-monorepo]]", "[[user-duyet-web-presence]]", "[[project-duyetbot]]"]
sources: ["https://news.duyet.net", "https://news.duyet.net/api/public"]
created: 2026-08-18
updated: 2026-08-29
timestamp: 2026-08-29T03:08:00Z
---

https://news.duyet.net — feed + ranking app in [[project-monorepo]] (`apps/news`). Cloudflare Worker deploy. Admin ingest is token-gated (`/api/admin/*`); do not put the token in kb.

Public third-party digest (shipped 2026-08-28, #1396): `GET /api/public` returns compact JSON (`tldr` bilingual bullets + up to 8 top `stories`, `updatedAt`). No auth. CORS allows `chrome-extension://…`, localhost, and `https://*.duyet.net`. Intended for the in-repo Chrome new-tab client (`apps/news-tab` in [[project-monorepo]]; Load unpacked from `manifest.json`). Homepage `/api/feed` stays the large no-CORS SPA payload.

Homepage AI;DR (shipped 2026-08-28, #1397): each bullet shows a compact story thumb on the right (layout A: number + copy left, 40–48px thumb right). Thumb is the linked story `image_url`; missing/broken images use the site mark. `TldrBullet.image_url` is attached at read time on `/api/feed` and `/api/public`, not stored on the snapshot. QA-only `?aidr=b|c` flips layout; default is A.

Homepage AI;DR copy (shipped 2026-08-28, #1399): digest prompt targets ~2 sentences / 180–240 chars; homepage clamps to 3 lines with ellipsis and highlights named entities (same topic colors as the feed). Existing snapshots stay one-liners until the next finished ingest writes longer copy. `/api/public` already clips `text` at 400 chars.

Hourly ingest (shipped 2026-08-28, #1400 + #1402 + #1405): primary cadence is a Durable Object alarm, not a Worker cron (account is at the 5-trigger cap; [[tech-cloudflare-cron-triggers-five-per-account]], [[tech-durable-object-alarms-not-cron]]). GitHub Actions is a watchdog with four independent crons per hour. Triggers coalesce if a run started in the last 45 minutes; manual `workflow_dispatch` POSTs `?force=1` to bypass coalesce. #1405 intended `open-run` to upsert `workflow_runs` immediately and set `GET /api/system` to `Cache-Control: no-store` (no-store is live). Recert lastRun by a force POST, not an invented schedule fire. First public hit or admin ingest POST arms the alarm.

#1415 (2026-08-29): persist `workflow_runs` with D1 `.run()` / `batch()`, not `INSERT RETURNING` + `.first()` ([[tech-d1-insert-returning-not-a-write]]). Gate 2xx on the same lastRun SELECT `/api/system` uses. Recert lastRun by a force POST after deploy; do not invent a schedule fire.

news-tab releases (shipped 2026-08-28, #1406): `apps/news-tab` is its own release-please component — changelog, 0.1.x line, `news-tab-v*` tags — not folded into the root `duyet` release. Leave its release-please PR for human merge ([[feedback-never-auto-merge-release-please]]).

Product hub: [[project-monorepo]]. Portfolio: [[user-duyet-web-presence]].
