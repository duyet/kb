---
name: clickhouse-machines
title: ClickHouse Machine Inventory
description: Three ClickHouse instances — duet-ubuntu (k3s), clickhouse-aws (EC2), openclaw (Contabo VPS)
type: reference
category: projects
tags: [clickhouse, homelab, infra, machines, connectivity]
related: ["[[project-clickhouse-monitor]]", "[[project-self-driven-homelab]]"]
sources: []
created: 2026-06-30
updated: 2026-07-01
timestamp: 2026-07-01T12:30:00Z
---

# ClickHouse Machine Inventory

Three ClickHouse instances, all reachable via Tailscale from the development laptop, all using a shared password.

## 1. duet-ubuntu (k3s cluster)

| Field | Value |
|-------|-------|
| **Access** | `https://duet-ubuntu.dingo-mora.ts.net:8443` (Tailscale HTTPS via k3s Ingress) |
| **Native port** | 9000 (cluster-internal) |
| **HTTP port** | 8123 (via k3s Service) |
| **Version** | 26.4.x |
| **Deployment** | Docker container in k3s, Helm chart `clickhouse/clickhouse` |
| **Data** | ~5.18 GiB (8 databases: system, home_assistant, amazon, git, duyet_analytics, pageview, peerdb_replicated, rsyslog) |
| **Resources** | Part of k3s cluster, resources managed by Helm |
| **Password source** | k3s Secret `chmonitor` (file: `homelab/chmonitor/secrets.local.yaml`) |
| **Config** | Helm values in k3s cluster |
| **Dashboard host name** | `duet-ubuntu` |
| **Notes** | Primary instance, most data. Also serves as cloud demo host for dash.chmonitor.dev |

## 2. clickhouse-aws (EC2 t3a.small)

| Field | Value |
|-------|-------|
| **Access** | Internal Tailscale HTTP |
| **Native port** | 9000 |
| **HTTP port** | 8123 |
| **Version** | 26.3.17 |
| **Deployment** | Native installation via `apt` on Amazon Linux |
| **Data** | ~700 MiB compressed (50 tables cloned from duet-ubuntu duyet_analytics) |
| **Resources** | 1.9 GiB RAM, 2 vCPUs (Xeon Platinum 8259CL), 50 GB disk (12G used), 8 GiB swap |
| **Password** | Set to the shared password |
| **Memory config** | `/etc/clickhouse-server/config.d/memory.xml` — max_server_memory_usage=1610612736 (1.5 GiB) |
| **Network config** | `/etc/clickhouse-server/config.d/listen.xml` — listen on 0.0.0.0 |
| **Dashboard host name** | `clickhouse-aws` |
| **SSH key** | Private key in `~/.ssh/` |
| **Notes** | Clone target from duet-ubuntu. Memory tuned for 1.5GiB limit (t3a.small is memory-constrained). Avoid heavy analytical queries — use openclaw (8GB) instead. |

### Clone from duet-ubuntu (2026-07-01)

All 50 tables from `duyet_analytics` cloned from duet-ubuntu via HTTP Native streaming. 34 tables have data (2.44M rows total), 16 are empty.

**Large tables:**
| Table | Rows | Batch strategy |
|-------|------|----------------|
| power_usage | 777,355 | Direct stream |
| homelab_ubuntu_sensors | 739,425 | 20k-10k batches (large `raw_data` String caused OOM at 50k) |
| duyet_redirect | 418,507 | 50k batches (+47k dups from retry, ReplacingMergeTree cleans up) |
| events | 100,209 | 50k → 20k batches (hit memory at 50k, finished at 20k) |

**Method:** Python script on dev laptop → `curl duet-ubuntu (HTTP Native)` → `ssh | clickhouse-client (clickhouse-aws)`. Explicit column lists to skip MATERIALIZED columns. Batched with LIMIT/OFFSET for large tables.

### Memory tuning

`/etc/clickhouse-server/config.d/memory.xml`:
```xml
<clickhouse>
    <max_server_memory_usage>1610612736</max_server_memory_usage>
</clickhouse>
```
- **2026-06-30:** Default 700 MiB → 1 GiB (1073741824) for cloning headroom
- **2026-07-01:** After clone completed, attempted 1 GiB → hit MEMORY_LIMIT_EXCEEDED at RSS 1.06GiB on restart. Settled at 1.5 GiB (1610612736) which leaves ~400 MiB for OS.

## 3. openclaw (Contabo VPS)

| Field | Value |
|-------|-------|
| **Access** | Internal Tailscale HTTP (port 8124, non-default) |
| **Native port** | 9000 |
| **HTTP port** | 8124 (custom, not 8123) |
| **Public IP** | 178.18.253.241 |
| **Version** | 26.5.1 |
| **Deployment** | Native installation, installed via ClickHouse official `.deb` package |
| **Data** | ~2.5 GiB |
| **Resources** | 8 GiB RAM, 4 CPUs, ~145 GiB disk (71G used, 74G free) |
| **Password** | Set to the shared password |
| **Config special** | `/etc/clickhouse-server/config.d/openclaw-lite.xml` — sets http_port=8124, memory/log settings |
| **Uptime** | 1+ month |
| **Dashboard host name** | `openclaw` |
| **Notes** | HTTP on port 8124 (not default 8123). Accessible over Tailscale at `<redacted-ip>:8124`. Most performant instance (8GB RAM) — good for heavy queries. |

### Custom port config (`openclaw-lite.xml`)
```xml
<clickhouse>
    <http_port>8124</http_port>
    <!-- other custom settings -->
</clickhouse>
```




