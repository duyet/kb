---
name: project-oma-cli-version-help-json
title: oma CLI version, group help, and --json before auth
description: Argv ordering — version/help before loadConfig; --json before empty-result human sentences
type: project
category: agents
tags: [project, oma, cli, argv]
aliases: [oma-cli-version, oma-cli-group-help, oma-cli-json]
related: ["[[project-oma-cli-empty-2xx]]", "[[project-open-managed-agents]]"]
sources: ["https://github.com/duyet/oma/pull/483", "https://github.com/duyet/oma/pull/487", "https://github.com/duyet/oma/issues/431"]
created: 2026-10-03
updated: 2026-10-03
timestamp: 2026-10-03T04:42:00+07:00
---

`oma` CLI `main()` must answer `--version` / `-V` / `version` and group/leaf `--help` **before** `loadConfig` (no credentials, no network). Unknown help (`oma nope --help`) must still print `Unknown command` and exit 1 — if it falls through after `printHelp` returns false, unauthenticated runs die with "not authenticated." instead of naming the typo.

List verbs honor `--json` **before** the empty-result branch so scripts get `[]` (exit 0), not a human "No rows." sentence. Covered verbs: agents/envs/sessions/keys/models list, auth tenant ls, envs create. Export `main()` and drive argv in tests with a throwing `process.exit` stub (no-op stubs continue past terminal branches).

**Why:** Shell `VERSION=$(oma --version)` and `jq` pipes need honest exit codes and shapes; auth-gated help makes the command surface undiscoverable.

**How to apply:** After CLI dispatch changes, recert `oma --version`, `oma sessions --help`, `oma nope --help` (Unknown command, exit 1, no auth), and `oma agents list --json` (array or `[]`). Shipped #483 tip `27cc4b29` (closes #431 items 1–3). Version Packages #487 squash-merged tip `192e37c7`; Release workflow_dispatch `37067755066` published `@getoma/cli@0.1.13` to npm (OIDC). Default Actions-token merge of the Version Packages PR skips tip push workflows — re-dispatch Release after merge when publish did not run. Leave release-please alone. Deferred #431 items 4–7 (envs config get/delete, usage, runtime hosted providers) are separate surface work.
