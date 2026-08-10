---
name: tech-qdrant-hnsw-timeout
title: "Qdrant: high-dim full scan timeouts"
description: Large float32 collections without HNSW/quantization can time out
type: tech
category: databases
tags: [tech, qdrant, vector, databases]
related: ["[[tech-qdrant-config-at-create]]", "[[tech-rag-metadata-key-drift]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

High-dimension float32 collections can devolve to expensive scans. Tune HNSW + consider INT8 quantization.

Config timing: [[tech-qdrant-config-at-create]]. Related: [[tech-rag-metadata-key-drift]].
