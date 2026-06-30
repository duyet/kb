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
updated: 2026-06-30
timestamp: 2026-06-30T17:50:00Z
---

# ClickHouse Machine Inventory

Three ClickHouse instances, all reachable via Tailscale from the development laptop, all using shared password `CLICKHOUSE_PASSWORD_REDACTED`.

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
| **Notes** | Primary instance, most data, serves as cloud demo host (`CHM_CLOUD_DEMO_HOSTS=duet-ubuntu`) |

## 2. clickhouse-aws (EC2 t3a.small)

| Field | Value |
|-------|-------|
| **Access** | `http://CLICKHOUSE_AWS_TAILSCALE_IP:8123` (Tailscale HTTP) |
| **Native port** | 9000 |
| **HTTP port** | 8123 |
| **Version** | 26.3.17 |
| **Deployment** | Native installation via `apt` on Amazon Linux |
| **Data** | ~62 MiB (minimal) |
| **Resources** | 1.9 GiB RAM, 2 vCPUs (Xeon Platinum 8259CL), 50 GB disk (12G used), 8 GiB swap |
| **Password** | Reset to `CLICKHOUSE_PASSWORD_REDACTED` (original SHA256 hash replaced in `users.xml`) |
| **Memory config** | `/etc/clickhouse-server/config.d/memory.xml` — max_server_memory_usage=1073741824 (1 GiB), max_concurrent_queries=10 |
| **Network config** | `/etc/clickhouse-server/config.d/listen.xml` — listen on 0.0.0.0 |
| **Dashboard host name** | `clickhouse-aws` |
| **SSH key** | `~/.ssh/clickhouse-aws.pem` (ec2-user) |
| **Notes** | Was hitting MEMORY_LIMIT_EXCEEDED at default 700 MiB limit. Increased to 1 GiB (leaves ~800 MiB for OS/page cache). t3a.small is memory-constrained — avoid large analytical queries against this instance. |

### Memory optimization applied (2026-06-30)

`/etc/clickhouse-server/config.d/memory.xml`:
```xml
<clickhouse>
    <max_server_memory_usage>1073741824</max_server_memory_usage>
    <max_concurrent_queries>10</max_concurrent_queries>
</clickhouse>
```

## 3. openclaw (Contabo VPS)

| Field | Value |
|-------|-------|
| **Access** | `http://OPENCLAW_TAILSCALE_IP:8124` (Tailscale HTTP) **note non-default port** |
| **Native port** | 9000 |
| **HTTP port** | 8124 (custom, not 8123) |
| **Public IP** | 178.18.253.241 |
| **Version** | 26.5.1 |
| **Deployment** | Native installation, installed via ClickHouse official `.deb` package |
| **Data** | ~2.5 GiB |
| **Resources** | 8 GiB RAM, 4 CPUs, ~145 GiB disk (71G used, 74G free) |
| **Password** | `CLICKHOUSE_PASSWORD_REDACTED` |
| **Config special** | `/etc/clickhouse-server/config.d/openclaw-lite.xml` — sets http_port=8124, memory/log settings |
| **Uptime** | 1+ month |
| **Dashboard host name** | `openclaw` |
| **Notes** | HTTP on port 8124 (not default 8123). Accessible over Tailscale at `OPENCLAW_TAILSCALE_IP:8124`. Most performant instance (8GB RAM) — good for heavy queries. |

### Custom port config (`openclaw-lite.xml`)
```xml
<clickhouse>
    <http_port>8124</http_port>
    <!-- other custom settings -->
</clickhouse>
```

## Multi-host Dashboard Configuration

The local development `.env.local` uses comma-separated multi-host format:

```
CLICKHOUSE_HOST=https://duet-ubuntu.dingo-mora.ts.net:8443,http://CLICKHOUSE_AWS_TAILSCALE_IP:8123,http://OPENCLAW_TAILSCALE_IP:8124
CLICKHOUSE_USER=default
CLICKHOUSE_PASSWORD=CLICKHOUSE_PASSWORD_REDACTED
CLICKHOUSE_NAME=duet-ubuntu,clickhouse-aws,openclaw
```

Single credential pair applies to all hosts (when arrays length = 1). The multi-host parser in `clickhouse-config.ts` maps them by index.

## Connection Quick Reference

| Host | URL | Password | Since |
|------|-----|----------|-------|
| duet-ubuntu | `https://duet-ubuntu.dingo-mora.ts.net:8443` | `CLICKHOUSE_PASSWORD_REDACTED` | Original |
| clickhouse-aws | `http://CLICKHOUSE_AWS_TAILSCALE_IP:8123` | `CLICKHOUSE_PASSWORD_REDACTED` | Reset 2026-06-30 |
| openclaw | `http://OPENCLAW_TAILSCALE_IP:8124` | `CLICKHOUSE_PASSWORD_REDACTED` | Original |
