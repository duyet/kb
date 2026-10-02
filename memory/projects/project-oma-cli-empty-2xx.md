---
name: project-oma-cli-empty-2xx
title: oma CLI treats empty 2xx as success
description: CLI apiFetch skips JSON.parse on empty bodies so accepted 202/204 mutations do not look like failures
type: project
category: agents
tags: [project, oma, cli, http]
aliases: [oma-cli-empty-body, oma-sessions-message-202]
related: ["[[project-open-managed-agents]]"]
sources: ["https://github.com/duyet/oma/pull/474", "https://github.com/duyet/oma/pull/476", "https://github.com/duyet/oma/pull/477", "https://github.com/duyet/oma/pull/478", "https://github.com/duyet/oma/pull/479", "https://github.com/duyet/oma/pull/482", "https://github.com/duyet/oma/issues/436", "https://github.com/duyet/oma/issues/475", "https://github.com/duyet/oma/issues/480"]
created: 2026-10-02
updated: 2026-10-02
timestamp: 2026-10-02T12:00:00Z
---

`oma` CLI shared `apiFetch` treats an empty successful HTTP body as `undefined` instead of calling `res.json()`. `POST /v1/sessions/:id/events` answers `202` with no body once the event is queued; parsing that used to throw `Unexpected end of JSON input` and exit 1 after the turn was already accepted — scripts then retried and duplicated turns.

**Why:** A failed exit after a successful mutation is worse than a quiet accept; retries duplicate work.

**How to apply:** After CLI changes that touch `apiFetch` or session message posting, recert `oma sessions message <id> <text>` exits 0 with `Message sent.` on a live accepted turn. Shipped #474 tip `3d1fdf5` (closes #436). Changeset #477 + Version Packages #478 bumped `@getoma/cli` to `0.1.12` on tip. After Release publish, npm `latest` reports `0.1.12`, but verify the tarball downloads (`cli-0.1.12.tgz` must not 404) before treating npm install as fixed. #476 tip `ce15a15` adds regression tests for whitespace-only 202/204 bodies and documents that `text.trim()` is load-bearing (closes #475; no runtime change). Changeset entry landed in #477. Version Packages #478 merged tip `00c7c6d` bumps `@getoma/cli` to `0.1.12` (CLI excluded from release-please). npm `@getoma/cli@0.1.12` published 2026-10-02 (Changesets Release publish on tip `00c7c6d`; GitHub release/tag `@getoma/cli@0.1.12`). Release Please root `0.1.7` #479 (changelog for #473/#474) later merged tip `0853303` — changelog/manifest only; leave RP alone. Tip CI red after #478/#479 was open #480 (`recovery-do` alarm rearm) — fixed test-only by #482 tip `8146e717` (closes #480; PR CI run 37002904069 green). Tip push CI/deploys did not run: github-actions automerge merges with the default Actions token, which does not trigger further workflows on the merge push; deploy path filters also skip test-only. Leave RP alone.
