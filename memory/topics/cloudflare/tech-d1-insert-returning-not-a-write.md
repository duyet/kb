---
name: tech-d1-insert-returning-not-a-write
title: D1 INSERT RETURNING is not a write API via .first()
description: Cloudflare D1 INSERT/UPDATE RETURNING + .first() returns empty results; persist with .run() or batch()
type: tech
category: cloudflare
tags: [tech, cloudflare, workers, d1]
related: ["[[project-news]]"]
sources: ["https://developers.cloudflare.com/d1/worker-api/d1-database/"]
created: 2026-08-29
updated: 2026-08-29
timestamp: 2026-08-29T03:08:00Z
---

Cloudflare D1 treats `INSERT`/`UPDATE` as writes. `stmt.first()` is a read helper and comes back empty for those statements even with `RETURNING`. A persist path that gates success on the RETURNING row will fail-closed after the write never looks persisted.

Write with `D1PreparedStatement.run()` (or `D1Database.batch()` of prepared statements), then confirm with a later `SELECT`. Do not widen `batch()` on a local D1 wrapper to a broader union — `Env.DB.batch` is `D1PreparedStatement[]` only and a wider type makes the binding unassignable.

Docs: [D1 Database API](https://developers.cloudflare.com/d1/worker-api/d1-database/).
