---
name: clickhouse-machines
title: ClickHouse Machine Inventory
description: Three ClickHouse instances (primary, clone, perf) reachable over Tailscale, sharing one password
type: reference
category: projects
tags: [clickhouse, homelab, infra, machines, connectivity]
related: ["[[project-clickhouse-monitor]]", "[[project-self-driven-homelab]]"]
sources: []
created: 2026-06-30
updated: 2026-07-02
timestamp: 2026-07-02T00:00:00Z
---

# ClickHouse Machine Inventory

Three ClickHouse instances, all reachable via Tailscale from the development laptop, all using a shared password.

## 1. Primary (k3s cluster)

| Field | Value |
|-------|-------|
| **Access** | Internal Tailscale HTTPS Funnel URL (via k3s Ingress) |
| **Native port** | 9000 (cluster-internal) |
| **HTTP port** | 8123 (via k3s Service) |
| **Version** | 26.4.x |
| **Deployment** | Docker container in k3s, Helm chart `clickhouse/clickhouse` |
| **Data** | ~5.18 GiB (8 databases: system, home_assistant, amazon, git, duyet_analytics, pageview, peerdb_replicated, rsyslog) |
| **Resources** | Part of k3s cluster, resources managed by Helm |
| **Password source** | k3s Secret managed by the cluster |
| **Config** | Helm values in k3s cluster |
| **Role** | primary |
| **Notes** | Primary instance, most data. Also serves as cloud demo host. |

## 2. Clone (small cloud instance)

| Field | Value |
|-------|-------|
| **Access** | Internal Tailscale HTTP |
| **Native port** | 9000 |
| **HTTP port** | 8123 |
| **Version** | 26.3.x |
| **Deployment** | Native installation via `apt` |
| **Data** | ~700 MiB compressed (50 tables cloned from primary's duyet_analytics) |
| **Resources** | ~1.9 GiB RAM, 2 vCPUs, small disk, memory-constrained |
| **Password** | Set to the shared password |
| **Memory config** | `config.d/memory.xml` — max_server_memory_usage=1610612736 (1.5 GiB) |
| **Role** | clone |
| **Notes** | Clone target from primary. Memory tuned for 1.5GiB limit (memory-constrained). Avoid heavy analytical queries — use the perf instance instead. |

### Clone from primary (2026-07-01)

All 50 tables from `duyet_analytics` cloned from the primary via HTTP Native streaming. 34 tables have data (2.44M rows total), 16 are empty.

**Large tables:**
| Table | Rows | Batch strategy |
|-------|------|----------------|
| power_usage | 777,355 | Direct stream |
| homelab_ubuntu_sensors | 739,425 | 20k-10k batches (large `raw_data` String caused OOM at 50k) |
| duyet_redirect | 418,507 | 50k batches (+47k dups from retry, ReplacingMergeTree cleans up) |
| events | 100,209 | 50k → 20k batches (hit memory at 50k, finished at 20k) |

**Method:** Python script on dev laptop → `curl` primary (HTTP Native) → `ssh | clickhouse-client` clone. Explicit column lists to skip MATERIALIZED columns. Batched with LIMIT/OFFSET for large tables.

### Memory tuning

`config.d/memory.xml`:
```xml
<clickhouse>
    <max_server_memory_usage>1610612736</max_server_memory_usage>
</clickhouse>
```
- **2026-06-30:** Default 700 MiB → 1 GiB (1073741824) for cloning headroom
- **2026-07-01:** After clone completed, attempted 1 GiB → hit MEMORY_LIMIT_EXCEEDED at RSS 1.06GiB on restart. Settled at 1.5 GiB (1610612736) which leaves ~400 MiB for OS.

## 3. Perf (larger VPS)

| Field | Value |
|-------|-------|
| **Access** | Internal Tailscale HTTP on a non-default port |
| **Native port** | 9000 |
| **HTTP port** | non-default (not 8123) |
| **Version** | 26.5.x |
| **Deployment** | Native installation, installed via ClickHouse official `.deb` package |
| **Data** | ~2.5 GiB |
| **Resources** | 8 GiB RAM, 4 CPUs, ~145 GiB disk |
| **Password** | Set to the shared password |
| **Config special** | Custom config sets a non-default http_port plus memory/log settings |
| **Uptime** | 1+ month |
| **Role** | perf |
| **Notes** | Internal HTTP on a non-default port. Most performant instance (8GB RAM) — good for heavy queries. |
