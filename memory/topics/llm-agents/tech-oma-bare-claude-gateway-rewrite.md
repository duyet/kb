---
name: tech-oma-bare-claude-gateway-rewrite
title: OMA env-fallback Claude uses anyrouter/free on AnyRouter
description: Bare claude-* rewrites to anthropic/claude-*; AnyRouter env-fallback sonnet sends anyrouter/free on both OpenAI and Anthropic wire paths (not dotted BYOK 4.6)
type: tech
category: llm-agents
tags: [oma, anyrouter, model-routing, gateway]
aliases: [oma-claude-gateway-rewrite, oma-anyrouter-free-fallback]
related: ["[[project-open-managed-agents]]", "[[tech-llm-gateway-byok-sibling]]", "[[project-anyrouter-catalog-one-id]]"]
sources: ["https://github.com/duyet/oma/pull/439", "https://github.com/duyet/oma/pull/453", "https://github.com/duyet/oma/pull/455", "https://github.com/duyet/oma/pull/457", "https://docs.oma.duyet.net/reference/configuration/"]
created: 2026-09-03
updated: 2026-09-04
timestamp: 2026-09-03T21:15:00Z
---

On the OpenAI-compatible / AnyRouter env-fallback path, OMA rewrites bare `claude-*` model handles to `anthropic/claude-*` (hyphens kept). Prefixed ids and non-Claude handles are unchanged.

AnyRouter aliases hyphenated `anthropic/claude-sonnet-4-6` onto dotted BYOK-only `anthropic/claude-sonnet-4.6`, which 404s `model_unavailable`. Env-fallback therefore sends the live non-BYOK catalog id `anyrouter/free` for those sonnet handles.

`wireModelIdFor` remaps **both** `openai.chat(...)` and `anthropic(...)` when `baseURL` is AnyRouter (#455 covered OpenAI only; #457 closed the Anthropic `/messages` hole where SessionDO with `ANTHROPIC_API_KEY` still POSTed bare sonnet and would strip a mapped `anyrouter/free` to `free`). OpenRouter and direct Anthropic stay unchanged. After #457, spans and `[provider.fetch]` 4xx logs report the HTTP wire `model` (`LanguageModel.modelId` / `request_model=`), not only the agent handle.

**Why:** Hyphen rewrite alone still hit BYOK-only dotted aliases; OpenAI-only remap left the default `ant` `/messages` path broken on live.

**How to apply:** Prefer bare `claude-sonnet-4-6` (seeded General) or `anyrouter/free` on gateway fallback. Recert a new General session after agent-worker deploy: `span.model_request_start.model` and `request_model=` must be `anyrouter/free`, and AnyRouter must not 404 dotted 4.6.

Shipped in duyet/oma #439 + #453 + #455 + #457. Hub: [[project-open-managed-agents]].
