---
name: tech-cloudflare-ai-gateway-transparent
title: AI Gateway is transparent on model ids
description: Cloudflare AI Gateway does not validate model names; upstream does
type: tech
category: cloudflare
tags: [tech, cloudflare, llm]
related: ["[[project-anyrouter]]", "[[tech-llm-gateway-quota-as-retryable]]"]
sources: ["https://developers.cloudflare.com/ai-gateway/"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

AI Gateway routes by provider/prefix and forwards model strings. "Invalid model ID" is usually upstream or unknown provider prefix.

Custom providers: base URL + slug; model path appended. Related: [[project-anyrouter]], [[tech-llm-gateway-quota-as-retryable]].
