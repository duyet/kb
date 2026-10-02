---
name: project-oma-model-card-provider-cf-wire
title: oma model-card vendor provider on CF wire
description: CF SessionDO maps Model Card vendor provider (openai/anthropic) to ApiCompat wire tags — parity with Node
type: project
category: agents
tags: [project, oma, model-cards, cloudflare, agent]
aliases: [oma-model-card-provider-wire, oma-cf-provider-compat]
related: ["[[project-open-managed-agents]]", "[[project-oma-node-model-card-credentials]]"]
sources: ["https://github.com/duyet/oma/pull/473", "https://github.com/duyet/oma/pull/470"]
created: 2026-10-02
updated: 2026-10-02
timestamp: 2026-10-02T07:43:21Z
---

Cloudflare agent SessionDO honors a tenant **Model Card** `provider` as a **vendor name** (`openai` / `anthropic`) as well as wire tags (`oai`, `oai-compatible`, `ant`, `ant-compatible`). Shared helper `cardProviderToApiCompat` (harness) maps vendors → wire so CF posts to `/v1/chat/completions` vs `/v1/messages` correctly — matching self-hosted Node (`providerToApiCompat`). Unrecognized/`custom`/empty falls through to `OMA_API_COMPAT` (CF) or Anthropic default (Node).

**Why:** Cards created with `provider: "openai"` probed green but CF turns hit `/v1/messages` (404) because only wire tags were recognized. Diverged from Node after [[project-oma-node-model-card-credentials]] (#470).

**How to apply:** For CF model-card turn failures after a green probe, recert vendor `provider` on the card (not only wire tags). Shipped #473 tip `3b84d86`.
