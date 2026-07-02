---
name: project-clickhouse-machines-setup
title: Session Log — ClickHouse Multi-Host Setup
description: Connectivity fixes, memory optimization, and cross-host data clone across three ClickHouse instances
type: project
category: sessions
tags: [clickhouse, homelab, chmonitor, session-log, infra]
related: ["[[reference-clickhouse-machines]]", "[[project-clickhouse-monitor]]"]
sources: []
created: 2026-06-30
updated: 2026-07-02
timestamp: 2026-07-02T00:00:00Z
---

# Session Log — ClickHouse Multi-Host Setup

## Objective

Investigate and fix ClickHouse connectivity across three instances (k3s primary,
a high-memory VPS, and a new small cloud VM), point the monitoring dashboard at all
of them, set up ClickHouse on the blank VM, clone data from the primary, and tune
memory for the small instance.

## What was done

### 1. Investigated connectivity

| Role | Version | Access | Status |
|------|---------|--------|--------|
| Primary (k3s) | 26.4.x | Tailscale HTTPS Funnel | ✅ Working |
| Small cloud clone | 26.3.x | Internal Tailscale HTTP | ✅ Working after fixes |
| High-memory VPS | 26.5.x | Internal Tailscale HTTP | ✅ Working |

All three verified with `SELECT 1` and version queries.

### 2. Fixed the small cloud clone

**Password reset** — the `users.d/` directory was empty and the default user had an
unknown password hash. Reset it to the shared credential (SHA256), then verified
`SELECT 1` returned `1`. (The actual hash/credential is not recorded here — public repo.)

**Memory optimization** — `/etc/clickhouse-server/config.d/memory.xml` had
`max_server_memory_usage=734003200` (700 MB). On a ~2 GB-RAM box even simple queries
hit `MEMORY_LIMIT_EXCEEDED`. Raised to 1073741824 (1 GB) with
`max_concurrent_queries=10`, restarted, and confirmed via `system.server_settings`.

### 3. Updated multi-host config

All three hosts added to a shared multi-host env config (comma-separated), with a
single credential pair shared across them.

### 4. Cloned `duyet_analytics` from primary to the small clone

- 50 tables created; 34 have data (2.44M rows total), 16 empty on both sides.
- Large tables: power_usage (777,355), homelab_ubuntu_sensors (739,425, batched at
  20k due to a large `raw_data` String), duyet_redirect (418,507, +dups from batch
  retries that ReplacingMergeTree cleans up), events (100,209, dropped 50k→20k on
  a memory limit).
- Method: script streams host→host over HTTP Native with explicit column lists to
  skip MATERIALIZED columns; LIMIT/OFFSET batching for large tables.

### 5. Memory tuning after clone

Reduced `max_server_memory_usage` back down: 1 GiB (1073741824) still hit
`MEMORY_LIMIT_EXCEEDED` at ~1.06 GiB RSS on restart, so settled at 1.5 GiB
(1610612736), leaving ~400 MiB for the OS/page cache.

## Production caveat

Only the primary is reachable from Cloudflare Workers (via Tailscale Funnel). The
other two use internal Tailscale addresses Workers cannot reach; exposing them would
need a Funnel URL, a subnet router reachable from Workers, or a public HTTPS endpoint.

## Remaining work

1. ✅ Clone `duyet_analytics` to the small clone — done (all 34 tables verified).
2. (Optional) Set up a Tailscale Funnel for the other two if production multi-host
   is desired.
3. (Optional) Clone additional databases (home_assistant, amazon, git) if needed.

## Commands used (for reference)

```bash
# Test connectivity (pass credential from env var or --password flag)
clickhouse-client --query "SELECT 1"

# Check memory settings
clickhouse-client --query "SELECT name, value FROM system.server_settings WHERE name='max_server_memory_usage'"

# Get DDLs
clickhouse-client --query "SELECT create_table_query FROM system.tables WHERE database='duyet_analytics'"

# Clone data between hosts via HTTP Native + clickhouse-client pipe
```
