---
name: reference-ai-sdk-uimessage
title: AI SDK UIMessage shape
description: UIMessage is id+role+parts; unknown part types render as null
type: reference
category: ai-sdk
tags: [reference, ai-sdk, web]
related: ["[[tech-ai-sdk-history-dto-convert]]", "[[tech-ai-agent-stack]]"]
sources: ["https://ai-sdk.dev/docs/ai-sdk-ui/chatbot-message-persistence"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Vercel AI SDK `UIMessage` = `{id, role, parts[], metadata?}`. Renderer switches on `part.type` and drops unknowns.

Native tool parts: `dynamic-tool` / `tool-${name}` with `{state, input, output}`.
See [[tech-ai-sdk-history-dto-convert]], [[tech-ai-agent-stack]].
