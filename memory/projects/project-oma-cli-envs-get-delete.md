---
name: project-oma-cli-envs-get-delete
title: oma CLI envs get and delete
description: oma envs get/delete honor --json; 409/404 via apiFetch; Partial #484 tip 5c5c9178
type: project
category: agents
tags: [project, oma, cli, envs]
aliases: [oma-cli-envs-get, oma-cli-envs-delete]
related: ["[[project-oma-cli-version-help-json]]", "[[project-oma-cli-empty-2xx]]", "[[project-open-managed-agents]]"]
sources: ["https://github.com/duyet/oma/pull/488", "https://github.com/duyet/oma/issues/484"]
created: 2026-10-03
updated: 2026-10-03
timestamp: 2026-10-03T04:57:00+07:00
---

`oma envs get <id>` → `GET /v1/environments/:id` (name/id/type plus optional sandbox/harness/status/kind/desc/created; `--json` = raw object). `oma envs delete <id>` → `DELETE /v1/environments/:id` (409 active sessions / 404 via `apiFetch`; empty 2xx still emits `{ type: environment_deleted, id }` under `--json`).

**Why:** Operators need detail beyond `envs list` and a hard-delete path that surfaces server refusals honestly.

**How to apply:** Recert `oma envs get --help`, `oma envs delete --help` (no auth required for help). Soft live: dry get/delete on a throwaway env. Shipped #488 tip `5c5c9178` (Partial #484; does not close). Patch changeset pending Version Packages → `@getoma/cli` 0.1.14 — leave VP/RP alone; npm after publish. Leftover on #484: `envs create` networking/packages flags, `oma usage`, hosted `runtime list`. Open RP #489 (root 0.1.8) — leave alone.
