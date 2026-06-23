---
name: reference-ai-sdk-history-uimessage-mapping
title: AI SDK chat history — map persisted parts to UIMessage at the client boundary
description: Vercel AI SDK UIMessage rehydration pitfall — persisted tool/chart parts vanish on history reload unless translated to native dynamic-tool shape
type: reference
category: reference
tags: [ai-sdk, vercel-ai-sdk, chat, uimessage, architecture, dto, streaming]
aliases: [ai-sdk-history-conversion, uimessage-tool-call]
related: ["[[feedback-docs-driven-development]]"]
sources: ["https://ai-sdk.dev/docs/ai-sdk-ui/chatbot-message-persistence"]
created: 2026-06-23
updated: 2026-06-23
timestamp: 2026-06-23T00:00:00Z
---

Building a chat UI on Vercel AI SDK (`useChat`, v5/v6/v7) backed by your own
history API: a stored tool/chart part can render fine **live** but vanish on
**history reload**. Live streaming feeds AI SDK its native SSE protocol, so parts
arrive as the lib's own shape; history returns your DB's DTO shape, which AI SDK
does not recognize.

**Root cause.** AI SDK `UIMessage` = `{id, role, parts[], metadata?}`. Its
renderer switches on each part's `type` and drops unknown types (`default: null`,
silently). Native tool parts are `dynamic-tool` / `tool-${name}` with
`{state, input, output}`. A neutral persistence DTO usually stores
`{type:'tool-call', args, result}` + a parallel `annotations[]` array → none of
which AI SDK reads.

**Why a converter is needed.** Your API is a persistence/transport DTO, not a
view-model. Translate at the client boundary:
- tool parts: `tool-call`/`args`/`result` → `dynamic-tool` (`input`/`output`,
  `state:'output-available'` when a result exists, else `input-available`)
- side-channel `annotations[]` (token usage, reasoning, errors) → `data-${name}` parts
- envelope: add `status:'ready'`, `id` fallback, normalize timestamps

**Why not just fix the API?** Only safe if AI SDK is the *sole* consumer. One
endpoint serving both a legacy custom renderer (reads `tool-call`) and an AI SDK
renderer (needs `dynamic-tool`) can't emit one native shape without breaking the
other — keep the API neutral, translate per client. Clean end-state once the
legacy path retires: emit native `UIMessage` server-side, delete the shim.

**Smell:** a response carrying `parts[]` AND `annotations[]` AND `toolInvocations[]`
is three encodings of the same data — removable cruft once on one renderer.
