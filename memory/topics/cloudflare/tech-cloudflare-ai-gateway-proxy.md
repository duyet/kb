---
name: tech-cloudflare-ai-gateway-proxy
title: Cloudflare AI Gateway is a transparent proxy for model names
description: AI Gateway does not validate model ids; it forwards them to the upstream — "invalid model ID" comes from the provider, not CF
type: tech
category: tech
tags: [cloudflare, ai-gateway, llm, proxy, byok]
aliases: []
related: []
sources: ["https://developers.cloudflare.com/ai-gateway/configuration/custom-providers/"]
created: 2026-06-08
updated: 2026-06-08
timestamp: 2026-06-08T00:00:00Z
---

Cloudflare AI Gateway keeps **no per-model allow-list**. It never rejects a
request because a model is "unsupported" by Cloudflare — it only resolves which
**upstream/provider** to route to and forwards the model string unchanged. So you
can serve a brand-new model the moment the **upstream provider** hosts it; no
waiting on Cloudflare.

- **Custom & per-provider endpoints** (`.../<gateway>/custom-{slug}/...`): the
  model is never parsed — everything after `custom-{slug}/` is appended to the
  registered `base_url` and forwarded verbatim. Creating a custom provider needs
  only `name`/`slug`/`base_url` — no model registration.
- **Universal / `compat` endpoint** (`model: "provider/model"`): AI Gateway parses
  only the **provider prefix** to pick a route. The error `"X is not a valid model
  ID"` here means an **unknown provider prefix**, never an unsupported model.
- A `"... is not a valid model ID"` in the AIG dashboard is the **upstream's**
  rejection (the model isn't hosted there), not AI Gateway's. Debug upstream
  availability, not gateway config.

**Proven:** routing `nvidia/cosmos3-nano-reasoner` through a custom NVIDIA provider
reached `integrate.api.nvidia.com` and NVIDIA rejected it (model is self-host
NIM/HF-weights only, not on the hosted API). AIG passed it through fine.
