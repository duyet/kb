---
name: project-oma-cli-empty-2xx
title: oma CLI treats empty 2xx as success
description: CLI apiFetch skips JSON.parse on empty bodies so accepted 202/204 mutations do not look like failures
type: project
category: agents
tags: [project, oma, cli, http]
aliases: [oma-cli-empty-body, oma-sessions-message-202]
related: ["[[project-open-managed-agents]]"]
sources: ["https://github.com/duyet/oma/pull/474", "https://github.com/duyet/oma/pull/476", "https://github.com/duyet/oma/pull/477", "https://github.com/duyet/oma/pull/478", "https://github.com/duyet/oma/issues/436", "https://github.com/duyet/oma/issues/475"]
created: 2026-10-02
updated: 2026-10-02
timestamp: 2026-10-02T11:13:00Z
---

`oma` CLI shared `apiFetch` treats an empty successful HTTP body as `undefined` instead of calling `res.json()`. `POST /v1/sessions/:id/events` answers `202` with no body once the event is queued; parsing that used to throw `Unexpected end of JSON input` and exit 1 after the turn was already accepted — scripts then retried and duplicated turns.

**Why:** A failed exit after a successful mutation is worse than a quiet accept; retries duplicate work.

**How to apply:** After CLI changes that touch `apiFetch` or session message posting, recert `oma sessions message <id> <text>` exits 0 with `Message sent.` on a live accepted turn. Shipped #474 tip `3d1fdf5` (closes #436). #476 tip `ce15a15` adds regression tests for whitespace-only 202/204 bodies and documents that `text.trim()` is load-bearing (closes #475; no runtime change). Changeset entry landed in #477. Version Packages #478 merged tip `00c7c6d` bumps `@getoma/cli` to `0.1.12` (CLI excluded from release-please). Soft leftover: npm `@getoma/cli` still on `0.1.11` until the Changesets Release `publish` job finishes after the tip push (concurrency group `release`). Leave release-please PRs for a human.
