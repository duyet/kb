---
name: reference-clickhouse-machines
title: ClickHouse Instance Roles & Tuning
description: Three self-hosted ClickHouse instances by role (primary, memory-constrained clone target, high-memory query node); connectivity, memory-tuning, and clone lessons
type: reference
category: projects
tags: [clickhouse, homelab, infra, machines, connectivity]
related: ["[[project-clickhouse-monitor]]", "[[project-self-driven-homelab]]"]
sources: []
created: 2026-06-30
updated: 2026-07-02
timestamp: 2026-07-02T00:00:00Z
---

# ClickHouse Instance Roles & Tuning

Three self-hosted ClickHouse instances, reached privately over Tailscale and
sharing one credential pair. Described by role only (no host/provider identifiers).

## 1. Primary (k3s cluster)

| Field | Value |
|-------|-------|
| **Access** | Internal Tailscale HTTPS Funnel URL (via k3s Ingress) |
| **Version** | 26.4.x |
| **Deployment** | Docker container in k3s, Helm chart `clickhouse/clickhouse` |
| **Data** | ~5 GiB, several databases |
| **Notes** | Largest dataset. Also serves as the read-only cloud demo host for dash.chmonitor.dev |

## 2. Small clone target (memory-constrained instance)

| Field | Value |
|-------|-------|
| **Access** | Internal Tailscale HTTP |
| **Version** | 26.3.x |
| **Deployment** | Native install via `apt` |
| **Data** | ~700 MiB compressed (50 tables cloned from the primary's analytics DB) |
| **Resources** | ~1.9 GiB RAM, 2 vCPUs, small disk, swap enabled |
| **Notes** | Memory-constrained — tune `max_server_memory_usage`; avoid heavy analytical queries, use the high-memory node instead. |

### Clone from the primary (2026-07-01)

50 tables cloned from the primary's analytics database via HTTP Native streaming.
34 tables have data (2.44M rows total), 16 are empty.

**Large tables:**
| Table | Rows | Batch strategy |
|-------|------|----------------|
| power_usage | 777,355 | Direct stream |
| homelab_sensors | 739,425 | 20k–10k batches (large `raw_data` String caused OOM at 50k) |
| redirect_log | 418,507 | 50k batches (+47k dups from retry, ReplacingMergeTree cleans up) |
| events | 100,209 | 50k → 20k batches (hit memory at 50k, finished at 20k) |

**Method:** Python script on the dev machine → HTTP Native read from the primary
→ `clickhouse-client` insert into the target. Explicit column lists to skip
MATERIALIZED columns. Batched with LIMIT/OFFSET for large tables.

### Memory tuning

`/etc/clickhouse-server/config.d/memory.xml`:
```xml
<clickhouse>
    <max_server_memory_usage>1610612736</max_server_memory_usage>
</clickhouse>
```
- **2026-06-30:** Default 700 MiB → 1 GiB (1073741824) for cloning headroom
- **2026-07-01:** After clone, 1 GiB hit MEMORY_LIMIT_EXCEEDED at RSS 1.06 GiB on
  restart. Settled at 1.5 GiB (1610612736), leaving ~400 MiB for the OS.

## 3. High-memory query node

| Field | Value |
|-------|-------|
| **Access** | Internal Tailscale HTTP (custom non-default HTTP port) |
| **Version** | 26.5.x |
| **Deployment** | Native install via the ClickHouse official `.deb` package |
| **Data** | ~2.5 GiB |
| **Resources** | ~8 GiB RAM, 4 CPUs, roomy disk |
| **Notes** | Uses a custom (non-default) HTTP port. Most performant instance (8 GiB RAM) — best for heavy queries. |
