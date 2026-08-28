---
name: project-news
title: news.duyet.net
description: Personal news feed + public digest; homepage AI;DR bullets show compact story thumbs
type: project
category: web
tags: [project, duyet, web]
related: ["[[project-monorepo]]", "[[user-duyet-web-presence]]", "[[project-duyetbot]]"]
sources: ["https://news.duyet.net", "https://news.duyet.net/api/public"]
created: 2026-08-18
updated: 2026-08-28
timestamp: 2026-08-28T06:58:00Z
---

https://news.duyet.net — feed + ranking app in [[project-monorepo]] (`apps/news`). Cloudflare Worker deploy. Admin ingest is token-gated (`/api/admin/*`); do not put the token in kb.

Public third-party digest (shipped 2026-08-28, #1396): `GET /api/public` returns compact JSON (`tldr` bilingual bullets + up to 8 top `stories`, `updatedAt`). No auth. CORS allows `chrome-extension://…`, localhost, and `https://*.duyet.net`. Intended for the separate Chrome new-tab (`news-tab`) client; homepage `/api/feed` stays the large no-CORS SPA payload.

Homepage AI;DR (shipped 2026-08-28, #1397): each bullet shows a compact story thumb on the right (layout A: number + copy left, 40–48px thumb right). Thumb is the linked story `image_url`; missing/broken images use the site mark. `TldrBullet.image_url` is attached at read time on `/api/feed` and `/api/public`, not stored on the snapshot. QA-only `?aidr=b|c` flips layout; default is A.

Hourly ingest (shipped 2026-08-28, #1400): primary cadence is a Durable Object alarm, not a Worker cron (account is at the 5-trigger cap; [[tech-cloudflare-cron-triggers-five-per-account]], [[tech-durable-object-alarms-not-cron]]). GitHub Actions is a watchdog with four independent crons per hour. Triggers coalesce if a run started in the last 45 minutes. First public hit or admin ingest POST arms the alarm.

Product hub: [[project-monorepo]]. Portfolio: [[user-duyet-web-presence]].
