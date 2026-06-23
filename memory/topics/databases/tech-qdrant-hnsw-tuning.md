---
name: tech-qdrant-hnsw-tuning
title: Qdrant HNSW + quantization tuning for high-dim vectors
description: Why high-dim (e.g. 4096-d) Qdrant collections time out, and the HNSW + INT8 quantization config that fixes it
type: reference
category: databases
tags: [qdrant, vector-search, hnsw, quantization, embeddings, ann]
aliases: [qdrant tuning, hnsw, vector db timeout]
related: ["[[tech-ai-agent-stack]]"]
sources: ["https://qdrant.tech/documentation/concepts/indexing/", "https://qdrant.tech/documentation/guides/quantization/"]
created: 2026-06-23
updated: 2026-06-23
timestamp: 2026-06-23T00:00:00Z
---

## What Qdrant is
Vector database: stores embeddings + payload (metadata), does approximate
nearest-neighbour (ANN) search by vector similarity, optionally pre-filtered by
payload. A "collection" = one vector space (fixed dimension + distance metric).

## HNSW — the ANN index
**Hierarchical Navigable Small World**: a multi-layer proximity graph. Each
point links to its nearest neighbours; upper layers are sparse "express lanes",
lower layers dense. Search greedily hops toward the query — **logarithmic**, not
a full scan. Key params:
- `m` — links per node (graph density). Higher = better recall, more RAM. 16 is a good default.
- `ef_construct` — candidate list size at build time. Higher = better index quality, slower build. 200 is solid.
- `full_scan_threshold` — below this many points (or post-filter subset), Qdrant does brute force instead of HNSW. **A tight payload filter can drop you under this → silent full scan.**

## Why high-dim collections time out
Cost scales with **dimension × points searched**. A 4096-d float32 vector is
2.67× a 1536-d one. With default HNSW (`ef_construct=100`) **or** a filter that
forces full scan, search over full-precision 4096-d vectors blows past a tool's
timeout. Symptom: *some* queries return, others time out on the *same*
collection (the slow ones are filtered/borderline → full scan).

## The fix: quantization
**INT8 scalar quantization** stores a 1-byte proxy per dimension (4× smaller
than float32), kept in RAM (`always_ram=true`). HNSW traverses the cheap int8
vectors, then **rescores** the top candidates at full precision (kept on disk).
This is the dominant speedup at high dimensions. Combine with `on_disk=true`
vectors so RAM holds only the quantized index.

## Gotchas
- **Config applies only at `create_collection`.** Changing creation code does
  NOT retro-fit an existing collection. Apply in-place with `update_collection`
  (sets `hnsw_config` / `quantization_config` — re-optimizes, **no re-embed**),
  or recreate/reindex.
- **Payload indexes are separate.** Filtered search (`language=en`, category…)
  needs a payload index per field or it scans. Create explicitly.
- **Centralize creation config** in one helper so every collection (and future
  blue-green swaps) inherits HNSW + quantization, instead of bare `VectorParams`.

## Verify / remediate a live collection
- `client.get_collection(name)` → inspect `config.hnsw_config`, `quantization_config`.
- `client.update_collection(name, quantization_config=..., hnsw_config=...)` — in-place.
- List payload indexes via `get_collection(...).payload_schema`.
