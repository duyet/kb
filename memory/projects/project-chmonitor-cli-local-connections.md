---
name: project-chmonitor-cli-local-connections
title: chmonitor CLI local named connections
description: chm add/ls/use/rm save local ClickHouse HTTP and postgres:// connections; secrets stay in the credentials helper
type: project
category: clickhouse
tags: [project, chmonitor, cli, clickhouse, postgres]
aliases: [chm-add, chm-ls, chm-use]
related: ["[[project-clickhouse-monitoring]]", "[[user-duyet-lang-rust]]"]
sources: ["https://docs.chmonitor.dev/guide/guides/diagnostics-cli", "https://github.com/chmonitor/chmonitor"]
created: 2026-08-28
updated: 2026-08-28
timestamp: 2026-08-27T18:20:00Z
---

`chm` keeps a **local named connection store** (not dashboard hosts).

- `chm add <url>` (alias `connect`) saves ClickHouse HTTP `http(s)://[user:pass@]host:8123[/db]` or `postgres://` / `postgresql://`
- `chm ls` lists name, engine (`clickhouse` | `postgres`), host, current; `--json` supported
- `chm use <name>` sets `current_connection` in user `config.toml`
- `chm rm <name>` removes a saved connection
- Secrets go through the credentials helper (keyring / `0600` plaintext); never printed in `ls` or JSON
- Live TUI opens against the active local HTTP connection
- Dashboard `chm hosts` is unchanged (`/api/v1/hosts`)

Hub: [[project-clickhouse-monitoring]].
