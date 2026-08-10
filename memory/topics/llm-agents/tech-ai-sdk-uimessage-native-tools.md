---
name: tech-ai-sdk-uimessage-native-tools
title: AI SDK native tool parts
description: Persist or convert to dynamic-tool / tool-name parts for history reload
type: tech
category: agents
tags: [tech, ai-sdk, llm-agents]
related: ["[[tech-ai-sdk-history-dto-convert]]", "[[reference-ai-sdk-uimessage]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Live streams use native part types; history DTOs often use `tool-call` + `annotations` and disappear on reload.

Convert at the client boundary: [[tech-ai-sdk-history-dto-convert]]. Shape: [[reference-ai-sdk-uimessage]].
