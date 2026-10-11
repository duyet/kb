---
name: tech-hermes-vps-backup-restore
title: Hermes VPS backup & restore (restic → R2)
description: Daily encrypted restic backup of ~/.hermes, ~/kb, SQLite DBs and host config to Cloudflare R2; one-command restore
type: tech
category: agents
tags: [tech, llm-agents, hermes, backup, cloudflare]
aliases: [hermes-backup, hermes-restore]
related: ["[[tech-hermes-steer-mode]]", "[[tech-ai-agent-stack]]"]
sources: ["https://restic.readthedocs.io/"]
created: 2026-10-11
updated: 2026-10-11
timestamp: 2026-10-11T18:55:00Z
---

- Tool: restic (encrypted, deduplicated) to the R2 repo `s3:https://<acct>.r2.cloudflarestorage.com/<bucket>/hermes`.
- Config (root-only, secrets): `/etc/hermes-backup/env`. Excludes: `/etc/hermes-backup/excludes`.
- Schedule: `hermes-backup.timer` daily at 03:30. Retention: 7 daily, 4 weekly, 6 monthly. Weekly 5% data check.
- Covers: `~/.hermes` (minus caches/tools), `~/kb`, consistent `sqlite3 .backup` copies of every `*.db`, systemd units, earlyoom/sysctl/sshd/ufw config, helper scripts, tailscale serve config, Hermes commit.
- Commands: `hermes-backup [run|init|snapshots|check|list]`, `hermes-restore [id|latest] [--files-only]`.
- Restore keeps the old state as `~/.hermes.before-restore-*`; DBs are copied from `var/backups/hermes-stage/db`.
- New machine: install restic + Hermes, copy `/etc/hermes-backup/env` (password from the password manager), run `hermes-restore latest`.
- Losing RESTIC_PASSWORD = backups unrecoverable.
