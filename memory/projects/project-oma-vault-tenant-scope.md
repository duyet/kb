---
name: project-oma-vault-tenant-scope
title: oma-vault OMA_TENANT fails closed across tenants
description: Unset/empty/* stay wildcard for single-operator; multi-tenant credentials refuse start and same-host matches stay tenant-scoped
type: project
category: agents
tags: [project, oma, vault, tenant, security]
aliases: [oma-vault-tenant, oma-oma-tenant]
related: ["[[project-open-managed-agents]]", "[[tech-oma-credentials-out-of-sandbox]]"]
sources: ["https://github.com/duyet/oma/pull/450", "https://docs.oma.duyet.net/build/vault-and-mcp/"]
created: 2026-09-04
updated: 2026-09-04
timestamp: 2026-09-03T19:35:00Z
---

`oma-vault` parses `OMA_TENANT` as a `TenantScope`. Unset, empty, and `*` remain wildcard so a single-operator install still boots. When credentials contain more than one distinct `tenant_id`, a wildcard scope refuses to start. Same-host credential matches no longer return another tenant's token.

Compose and Helm default `OMA_TENANT` to empty (not `*`). Out of scope: per-request tenant attribution via per-session ports or sandbox tags.

**Why:** Prior default `*` plus host-only matching let two tenants that both register `api.github.com` steal each other's token.

**How to apply:** Multi-tenant self-host must set a concrete `OMA_TENANT`. Do not ship chart/compose defaults as `*`. Recert vault matching only within the configured tenant.

Shipped in duyet/oma #450 (closes #428). Hub: [[project-open-managed-agents]].
