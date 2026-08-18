---
name: project-anyrouter-unlist-broken-models
title: Unlist broken AnyRouter models
description: Disable or unlist a broken model from /models and the catalog; do not delete history
type: project
category: llm
tags: [project, anyrouter, llm]
related: ["[[project-anyrouter]]", "[[project-anyrouter-openai-compat]]"]
sources: ["https://anyrouter.dev/models", "https://docs.anyrouter.dev"]
created: 2026-08-18
updated: 2026-08-18
timestamp: 2026-08-18T17:00:00Z
---

When a model on AnyRouter is marked broken, disable or unlist it from `/models` and the catalog. Do not leave a dead row. Prefer unlist/disable over deleting request history. Do not invent new model ids.

Hub: [[project-anyrouter]]. API scope: [[project-anyrouter-openai-compat]].

**Why:** a listed model that 502s or 410s is worse than a missing row.
**How to apply:** flip the catalog flag / unlist; keep historical generations.
