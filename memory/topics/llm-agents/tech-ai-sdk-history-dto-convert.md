---
name: tech-ai-sdk-history-dto-convert
title: Convert history DTO → UIMessage
description: Keep API neutral; translate tool-call DTOs to AI SDK parts per client
type: tech
category: agents
tags: [tech, ai-sdk, architecture]
related: ["[[reference-ai-sdk-uimessage]]", "[[tech-ai-sdk-uimessage-native-tools]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Map `tool-call`/`args`/`result` → `dynamic-tool` with `input`/`output` and correct `state`. Map annotations → `data-*` parts.

Keep one endpoint for multiple clients until legacy dies. Related: [[reference-ai-sdk-uimessage]], [[tech-ai-sdk-uimessage-native-tools]].
