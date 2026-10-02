---
name: project-oma-cli-envs-get-delete
title: oma CLI envs get and delete
description: oma envs get/delete call GET/DELETE /v1/environments/:id; --json; Partial #484; npm @getoma/cli@0.1.14
type: project
category: agents
tags: [project, oma, cli, envs]
aliases: [oma-cli-envs-get, oma-cli-envs-delete]
related: ["[[project-oma-cli-version-help-json]]", "[[project-oma-cli-empty-2xx]]", "[[project-open-managed-agents]]"]
sources: ["https://github.com/duyet/oma/pull/488", "https://github.com/duyet/oma/issues/484", "https://www.npmjs.com/package/@getoma/cli"]
created: 2026-10-03
updated: 2026-10-03
timestamp: 2026-10-03T05:17:00+07:00
---

`oma envs get <id>` hits `GET /v1/environments/:id` and prints name/id/type plus optional sandbox provider, harness, status, kind, description, and created date; `--json` emits the raw object. `oma envs delete <id>` hits `DELETE /v1/environments/:id`; 409 (active sessions) and 404 surface through `apiFetch`; empty delete bodies still honor `--json` envelopes (see [[project-oma-cli-empty-2xx]]).

**Why:** Smoke and ops need read-back and cleanup of environments without raw `oma api` calls; #484 item 5.

**How to apply:** Shipped on tip `56d682e1` via #488 + Version Packages #490; npm `@getoma/cli@0.1.14` published (Release 37071142257). Soft CLI QA: `oma --version` (0.1.14), `oma envs get --help`, `oma envs delete --help`, then live get/delete against a disposable env id. #484 remains open for envs create config, `oma usage`, and hosted `runtime list`.
