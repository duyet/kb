---
name: tech-rag-metadata-key-drift
title: RAG metadata key drift
description: Inconsistent metadata keys break filters between ingest and query
type: tech
category: rag
tags: [tech, llm-agents, rag]
related: ["[[tech-rag-toc-pollution]]", "[[tech-qdrant-config-at-create]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

If ingest writes `source_url` and query filters `url`, retrieval silently degrades.

Lock a schema; test filters. Related: [[tech-rag-toc-pollution]], [[tech-qdrant-config-at-create]].
