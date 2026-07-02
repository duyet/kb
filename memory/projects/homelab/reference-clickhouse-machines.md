---
name: reference-clickhouse-machines
title: ClickHouse Multi-Host Setup Notes
description: Three ClickHouse instances (k3s primary, small cloud clone, high-memory VPS) — memory tuning + cross-host clone lessons
type: reference
category: projects
tags: [clickhouse, homelab, infra, machines, connectivity]
related: ["[[project-clickhouse-monitor]]", "[[project-self-driven-homelab]]"]
sources: []
created: 2026-06-30
updated: 2026-07-02
timestamp: 2026-07-02T00:00:00Z
---

# ClickHouse Multi-Host Setup Notes

Three ClickHouse instances reachable over a private Tailscale network, sharing one
credential pair. Roles below are deliberately non-identifying — this is a public
repo (see AGENTS.md §3); exact hostnames, ports, IPs, and secrets live only in the
private per-host config.

## Instances (by role)

| Role | Deployment | Version | Data | Notes |
|------|-----------|---------|------|-------|
| Primary | Docker in k3s, Helm chart `clickhouse/clickhouse` | 26.4.x | ~5.2 GiB, 8 databases | Most data; also the cloud demo host |
| Small cloud clone | Native `apt` install on a memory-constrained VM | 26.3.x | ~700 MiB (50 tables cloned from primary) | Memory-tuned to a hard limit; avoid heavy analytical queries |
| High-memory VPS | Native `.deb` install | 26.5.x | ~2.5 GiB | Most RAM — best for heavy queries |

Access is over an internal Tailscale HTTPS endpoint; only the primary is reachable
from Cloudflare Workers (via a Tailscale Funnel). The others use internal Tailscale
addresses that Workers cannot reach.

## Memory tuning (small-VM lesson)

Config: `/etc/clickhouse-server/config.d/memory.xml` sets `max_server_memory_usage`.

- Default ~700 MiB was too low on a ~2 GiB-RAM box — even simple queries hit
  `MEMORY_LIMIT_EXCEEDED`.
- Raising to 1 GiB (1073741824) still hit the limit at ~1.06 GiB RSS on restart.
- Settled at 1.5 GiB (1610612736), leaving ~400 MiB for the OS/page cache.

## Cross-host clone lessons

Cloned `duyet_analytics` (50 tables, ~700 MiB compressed; 34 with data, 2.44M rows)
from the primary to the small clone.

- Stream host→host over HTTP Native with explicit column lists (skips MATERIALIZED
  columns).
- Batch large tables with LIMIT/OFFSET; a large `String` column forced 20k-row
  batches to avoid OOM (a naive 50k batch OOM'd).
- ReplacingMergeTree cleans up duplicate rows introduced by batch retries.
