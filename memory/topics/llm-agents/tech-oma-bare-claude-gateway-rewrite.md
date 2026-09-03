---
name: tech-oma-bare-claude-gateway-rewrite
title: OMA rewrites bare Claude ids for AnyRouter
description: Bare claude-* on OAI/AnyRouter fallback becomes anthropic/claude-*; dotted 4.6 is BYOK-only
type: tech
category: llm-agents
tags: [oma, anyrouter, model-routing, gateway]
aliases: [oma-claude-gateway-rewrite]
related: ["[[project-open-managed-agents]]", "[[tech-llm-gateway-byok-sibling]]", "[[project-anyrouter-catalog-one-id]]"]
sources: ["https://github.com/duyet/oma/pull/439", "https://docs.oma.duyet.net/reference/configuration/"]
created: 2026-09-03
updated: 2026-09-03
timestamp: 2026-09-03T17:29:54Z
---

On the OpenAI-compatible / AnyRouter env-fallback path, OMA rewrites bare `claude-*` model handles to `anthropic/claude-*` (hyphens kept). Prefixed ids and non-Claude handles are unchanged. The Anthropic (`ant`) path still strips prefixes.

**Why:** AnyRouter’s catalog names Claude as `anthropic/claude-sonnet-4-6`. The bare handle aliases to the dotted BYOK-only entry `anthropic/claude-sonnet-4.6`, which 404s `model_unavailable`.

**How to apply:** Prefer bare `claude-sonnet-4-6` (seeded General) or the hyphenated `anthropic/claude-*` catalog id on gateway fallback. Do not send the dotted `4.6` alias. Empty-card tenants get a read-only HTTP `source: platform` model card for the seeded id (not persisted).

Shipped in duyet/oma #439. Hub: [[project-open-managed-agents]].
