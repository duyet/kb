---
name: tech-oma-bare-claude-gateway-rewrite
title: OMA env-fallback Claude uses anyrouter/free on AnyRouter
description: Bare claude-* rewrites to anthropic/claude-*; AnyRouter env-fallback sonnet sends anyrouter/free (not dotted BYOK 4.6)
type: tech
category: llm-agents
tags: [oma, anyrouter, model-routing, gateway]
aliases: [oma-claude-gateway-rewrite, oma-anyrouter-free-fallback]
related: ["[[project-open-managed-agents]]", "[[tech-llm-gateway-byok-sibling]]", "[[project-anyrouter-catalog-one-id]]"]
sources: ["https://github.com/duyet/oma/pull/439", "https://github.com/duyet/oma/pull/453", "https://docs.oma.duyet.net/reference/configuration/"]
created: 2026-09-03
updated: 2026-09-04
timestamp: 2026-09-03T19:35:00Z
---

On the OpenAI-compatible / AnyRouter env-fallback path, OMA rewrites bare `claude-*` model handles to `anthropic/claude-*` (hyphens kept). Prefixed ids and non-Claude handles are unchanged. The Anthropic (`ant`) path still strips prefixes.

AnyRouter aliases hyphenated `anthropic/claude-sonnet-4-6` onto dotted BYOK-only `anthropic/claude-sonnet-4.6`, which 404s `model_unavailable`. After #453, the env-fallback therefore sends the live non-BYOK catalog id `anyrouter/free` for those sonnet handles. `span.model_request_start` still records the agent handle `claude-sonnet-4-6`; the HTTP body is `anyrouter/free`. Never send the dotted `4.6` slug.

**Why:** Hyphen rewrite alone still hit BYOK-only dotted aliases on AnyRouter.

**How to apply:** Prefer bare `claude-sonnet-4-6` (seeded General) or `anyrouter/free` on gateway fallback. Empty-card tenants get a read-only HTTP `source: platform` model card for the seeded id (not persisted). Recert a General turn on AnyRouter fallback after agent-worker deploys.

Shipped in duyet/oma #439 + #453. Hub: [[project-open-managed-agents]].
