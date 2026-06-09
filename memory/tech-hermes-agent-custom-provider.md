---
name: tech-hermes-agent-custom-provider
title: Hermes agent custom LLM provider config
description: Hermes (codingllm/hermes) uses custom_providers list + provider:custom to register non-built-in OpenAI-compatible endpoints
type: tech
category: infra
tags: [tech, infra, hermes, llm-agents, config]
related: ["[[tech-ai-agent-stack]]"]
created: 2026-06-09
updated: 2026-06-09
---

Hermes agent configuration for custom OpenAI-compatible LLM providers.

## Custom provider registration

Two-part config in `hermes.yaml`:

1. **`custom_providers` list** — registers the provider by name, base_url, model, and api_key
2. **`model.provider: custom`** — tells Hermes to look up from custom_providers instead of built-in

```yaml
model:
  api_key: ${API_KEY}
  base_url: ${API_BASE}
  default: 'provider-name/model-name'
  provider: custom          # <-- required to use custom_providers
custom_providers:
  - api_key: ${API_KEY}
    base_url: https://example.com/api/v1
    model: actual-model-id
    name: provider-name     # referenced in default as "provider-name/model"
providers: {}               # clear built-in providers if not needed
```

**Gotcha:** `providers` must be set to `{}` if you don't want built-in providers loaded. Leaving it out may cause conflicts.

## Steer mode (busy_input_mode)

```yaml
display:
  busy_input_mode: steer
  busy_ack_enabled: true
```

- `steer`: when the agent is busy processing, new user messages are queued and the agent adjusts its current task to incorporate them (rather than ignoring or queuing blindly)
- `busy_ack_enabled: true`: sends a brief acknowledgment so the user knows the message was received
- Alternative values: `reject`, `queue` (agent-specific)
