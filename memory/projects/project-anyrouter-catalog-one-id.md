---
name: project-anyrouter-catalog-one-id
title: One AnyRouter listing id per model
description: Catalog id is owner/model; host SKUs (date, vision-exp, fast, casing) are upstream names or aliases
type: project
category: llm
tags: [project, anyrouter, llm, catalog]
aliases: [catalog-one-id, one-id-per-model]
related: ["[[project-anyrouter]]", "[[project-anyrouter-unlist-broken-models]]", "[[project-anyrouter-openai-compat]]"]
sources: ["https://anyrouter.dev/models", "https://docs.anyrouter.dev"]
created: 2026-08-28
updated: 2026-08-28
timestamp: 2026-08-28T10:31:00Z
---

A public catalog id is the product slug (`owner/model`), not a host SKU. Date tags, `vision-exp`, `fast`, quantization suffixes, and casing variants belong on `upstreams[].model_name` or `aliases:` — never as sibling listing rows.

Example (2026-08-28): DeepSeek V4 Flash lists as **`deepseek/deepseek-v4-flash`**. Former rows `deepseek/DeepSeek-V4-Flash`, `deepseek/deepseek-v4-flash-0731-fast`, and `deepseek/deepseek-v4-flash-vision-exp` resolve as aliases.

**Why:** callers and `/models` should see one model, not three host spellings.
**How to apply:** one lowercase `owner/model` listing id; keep working upstreams on that row; alias old ids; remove sibling YAML so it cannot occupy the id. Prefer unlist/alias over deleting history ([[project-anyrouter-unlist-broken-models]]). Do not invent ids. Do not add image/video generation endpoints.

Hub: [[project-anyrouter]].
