---
name: tech-qdrant-config-at-create
title: Qdrant HNSW config at create
description: Many collection params apply at create; retrofit via update_collection
type: tech
category: databases
tags: [tech, qdrant, vector, databases]
related: ["[[tech-qdrant-hnsw-timeout]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Don't assume live config edits always apply retroactively. Prefer correct create params; use `update_collection` when supported.

Related: [[tech-qdrant-hnsw-timeout]].
