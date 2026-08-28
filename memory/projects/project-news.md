---
name: project-news
title: news.duyet.net
description: Personal news feed app in duyet/monorepo — ranking + ingest, live at news.duyet.net
type: project
category: web
tags: [project, duyet, web]
related: ["[[project-monorepo]]", "[[user-duyet-web-presence]]", "[[project-duyetbot]]"]
sources: ["https://news.duyet.net", "https://news.duyet.net/api/public"]
created: 2026-08-18
updated: 2026-08-28
timestamp: 2026-08-28T04:45:00Z
---

https://news.duyet.net — feed + ranking app in [[project-monorepo]] (`apps/news`). Cloudflare Worker deploy. Admin ingest is token-gated (`/api/admin/*`); do not put the token in kb.

Public third-party digest (shipped 2026-08-28, #1396): `GET /api/public` returns compact JSON (`tldr` bilingual bullets + up to 8 top `stories`, `updatedAt`). No auth. CORS allows `chrome-extension://…`, localhost, and `https://*.duyet.net`. Intended for the separate Chrome new-tab (`news-tab`) client; homepage `/api/feed` stays the large no-CORS SPA payload.

Product hub: [[project-monorepo]]. Portfolio: [[user-duyet-web-presence]].
