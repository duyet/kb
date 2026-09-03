---
name: project-oma-timing-safe-secrets
title: oma internal secret uses timing-safe compare
description: checkInternalSecret and trusted-proxy share timingSafeEqualStr from @duyet/oma-auth/timing-safe-equal
type: project
category: security
tags: [project, oma, auth, security]
aliases: [oma-timing-safe-equal]
related: ["[[project-open-managed-agents]]", "[[project-oma-verify-skill]]"]
sources: ["https://github.com/duyet/oma/pull/443"]
created: 2026-09-03
updated: 2026-09-03
timestamp: 2026-09-03T18:20:00Z
---

`checkInternalSecret` (gates `/v1/internal/*` on the main worker) compares `x-internal-secret` with shared `timingSafeEqualStr`, same helper as the trusted-proxy guard.

- Helper lives in `packages/auth/src/timing-safe-equal.ts`, exported from `@duyet/oma-auth` and subpath `@duyet/oma-auth/timing-safe-equal`.
- Prefer the subpath import in the main worker so the auth barrel (`createAuthMiddleware`) stays out of that bundle.
- Responses unchanged: 503 when secret unset, 401 when header missing/wrong.

Landed in #443 (closes audit #427). Out of scope then: other `x-internal-secret` compares under `apps/integrations`.

**Why:** Keep secret gates consistent and defense-in-depth; avoid `!==` on shared secrets.

**How to apply:** Reuse `timingSafeEqualStr` for new secret compares; import via the timing-safe-equal subpath on the main worker. Do not invent or log secrets.

Hub: [[project-open-managed-agents]].
