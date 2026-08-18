---
name: project-anyrouter-openai-compat
title: AnyRouter OpenAI-compatible API
description: OpenAI-shaped clients; text and embeddings only — image/video generation is gone
type: project
category: llm
tags: [project, anyrouter, llm, web]
related: ["[[project-anyrouter]]", "[[tech-llm-gateway-quota-as-retryable]]"]
created: 2026-08-10
updated: 2026-08-18
timestamp: 2026-08-18T13:37:00Z
---

AnyRouter accepts OpenAI Chat Completions-shaped clients (and Anthropic Messages). Integrate by changing base URL + model id.

Scope: text and embeddings. Vision / OCR on **input** is kept. Image and video **generation** were dropped. `POST /api/v1/images/generations` returns `410` `endpoint_gone`.

Product hub: [[project-anyrouter]]. Gateway lessons: [[tech-llm-gateway-quota-as-retryable]].
