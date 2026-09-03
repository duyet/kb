---
name: project-oma-session-env-secret-persist
title: oma session create persists env_secret to the secret store
description: POST /v1/sessions writes env_secret and inline github tokens via sessionSecrets.put; unwired store fails 500; DELETE cascades
type: project
category: security
tags: [project, oma, sessions, secrets]
aliases: [oma-env-secret-persist]
related: ["[[project-open-managed-agents]]", "[[project-oma-timing-safe-secrets]]", "[[project-oma-verify-skill]]"]
sources: ["https://github.com/duyet/oma/pull/445", "https://github.com/duyet/oma/issues/426"]
created: 2026-09-04
updated: 2026-09-04
timestamp: 2026-09-03T19:08:00Z
---

`POST /v1/sessions` accepts `env_secret` (and inline `github_repository.authorization_token`) and persists each value through `sessionSecrets.put`, keyed by the minted resource id (identity-matched, not list-order zip).

- Fail closed with 500 when secret payloads are present but the store is unwired (no silent drop).
- Wired on Cloudflare route services and self-host Node (`KvSessionSecretRepo` over the existing SQL-backed KV).
- Session DELETE cascades `deleteAllForSession` (idempotent with the CF lifecycle path).
- API responses must not contain plaintext secret values.

Landed in #445 (closes audit #426). Restores documented `env_secret` behavior after a storage refactor dropped the create-path writer.

**Why:** Sandbox consumers (`resource-mounter`, github-creds, runtimes bundle) read the secret store; an empty store meant secrets never reached the sandbox despite 201 creates.

**How to apply:** Keep create-path `sessionSecrets.put` wired on both CF and Node. Prefer identity match over zip-by-index when attaching values to minted resources. Do not invent or log secrets.

Hub: [[project-open-managed-agents]].
