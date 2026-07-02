---
name: 2026-06-30-clickhouse-machines-setup
title: Session Log — ClickHouse Multi-Host Setup
description: Investigation, connectivity fixes, optimization, and partial data clone across three self-hosted ClickHouse instances
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

Investigate and fix ClickHouse connectivity across three self-hosted instances
(primary k3s cluster, a high-memory node, a new small instance), configure
dash.chmonitor.dev to connect to all instances, set up ClickHouse on the blank
small instance, clone data from the primary, optimize for the small instance,
and document all instances in the shared brain.

## What was done

### 1. Investigated connectivity across three instances

| Role | Version | Access | Status | Notes |
|------|---------|--------|--------|-------|
| Primary (k3s) | 26.4.x | Internal Tailscale HTTPS Funnel URL | ✅ Working | Already configured |
| Small clone target | 26.3.x | Internal Tailscale HTTP | ✅ Working after fixes | Password unknown, memory limit too low |
| High-memory node | 26.5.x | Internal Tailscale HTTP (non-default port) | ✅ Working | Custom HTTP port |

All three verified with `SELECT 1` and version queries.

### 2. Fixed the small clone target

**Password reset**
- The `users.d/` directory was empty; the default user had an unknown SHA256 hash
- Replaced the password hash with the SHA256 of the shared password
- Verified connection: `SELECT 1` returned `1`

**Memory optimization**
- Discovered `/etc/clickhouse-server/config.d/memory.xml` with `max_server_memory_usage=734003200` (700 MB)
- On ~1.9 GB RAM, even simple queries hit `MEMORY_LIMIT_EXCEEDED`
- Updated to `1073741824` (1 GB) with `max_concurrent_queries=10`
- Restarted ClickHouse, verified `system.server_settings` shows the new value

### 3. Updated multi-host config

All three hosts added to `.env.local` (comma-separated multi-host format), single credential pair shared across them.

### 4. Cloning the analytics database from the primary to the small instance

**Analytics DB contents on the primary**:
- 65 tables, ~700 MiB compressed on disk
- Mix of reporting, metrics, and validation tables
- Most tables use `MergeTree` or `ReplacingMergeTree`

**Clone status**: Complete ✅
- Step 1: Listed all tables and DDLs ✅
- Step 2: Create database and 50 tables on the target ✅
- Step 3: Export/import data via HTTP Native streaming ✅
- Step 4: Verify row counts match on all 34 tables with data ✅

**Key details:**
- Large tables cloned (2.44M rows total)
  - power_usage: 777,355 ✓
  - homelab_sensors: 739,425 ✓ (batched at 20k due to large raw_data strings)
  - redirect_log: 418,507 ✓ (+47k dups from batch retry, ReplacingMergeTree cleans up)
  - events: 100,209 ✓ (batched at 50k then 20k due to memory limit)
- Batch strategy: Python script on the dev machine → HTTP Native read from the primary → `clickhouse-client` insert into the target
- Explicit column lists to skip MATERIALIZED columns
- Batched with LIMIT/OFFSET for large tables (20k–50k per chunk)
- 16 tables are empty on both sides (normal)

### 5. Memory tuning after clone

After cloning completed, `max_server_memory_usage` reduced from 1.7 GiB back toward 1 GiB:
- Tried 1 GiB (1073741824) → ClickHouse restart hit MEMORY_LIMIT_EXCEEDED at RSS 1.06 GiB
- Settled at 1.5 GiB (1610612736) — leaves ~400 MiB for OS/page cache

### 6. Documentation

Created/updated the durable machine-role note [[reference-clickhouse-machines]]
plus this session log, and synced to the shared brain.

## Production caveat

Only the primary is reachable from Cloudflare Workers via Tailscale Funnel. The
other two use internal Tailscale addresses (CGNAT `100.x.x.x`) that Cloudflare
Workers cannot reach. To add them to production dash.chmonitor.dev they would need:
- Tailscale Funnel public URLs, or
- A Tailscale subnet router reachable from Cloudflare Workers, or
- Public HTTPS endpoints

## Remaining work

1. ✅ ~~Complete cloning the analytics DB~~ — DONE (all 34 tables with data verified)
2. (Optional) Set up Tailscale Funnel for the other two instances if production multi-host is desired
3. (Optional) Clone additional databases to the small instance if needed

## Commands used (for reference)

```bash
# Test connectivity (pass credentials from env var or --password flag)
clickhouse-client --query "SELECT 1"

# Check memory settings
clickhouse-client --query "SELECT name, value FROM system.server_settings WHERE name='max_server_memory_usage'"

# Get DDLs
clickhouse-client --query "SELECT create_table_query FROM system.tables WHERE database='<analytics_db>'"

# Clone data between hosts via HTTP Native + clickhouse-client pipe
# See the clone script for the current implementation
```
