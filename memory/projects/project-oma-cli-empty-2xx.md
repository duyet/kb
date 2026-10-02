---
name: project-oma-cli-empty-2xx
title: oma CLI treats empty 2xx as success
description: CLI apiFetch reads text and skips JSON.parse on empty bodies so accepted 202/204 mutations do not look like failures
type: project
category: agents
tags: [project, oma, cli, http]
aliases: [oma-cli-empty-body, oma-sessions-message-202]
related: ["[[project-open-managed-agents]]"]
sources: ["https://github.com/duyet/oma/pull/474", "https://github.com/duyet/oma/issues/436"]
created: 2026-10-02
updated: 2026-10-02
timestamp: 2026-10-02T10:31:20Z
---

`oma` CLI shared `apiFetch` treats an empty successful HTTP body as `undefined` instead of calling `res.json()`. `POST /v1/sessions/:id/events` answers `202` with no body once the event is queued; parsing that used to throw `Unexpected end of JSON input` and exit 1 after the turn was already accepted — scripts then retried and duplicated turns.

**Why:** A failed exit after a successful mutation is worse than a quiet accept; retries duplicate work.

**How to apply:** After CLI changes that touch `apiFetch` or session message posting, recert `oma sessions message <id> <text>` exits 0 with `Message sent.` on a live accepted turn. Shipped #474 tip `3d1fdf5` (closes #436).
