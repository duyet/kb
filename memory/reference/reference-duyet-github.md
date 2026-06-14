---
name: reference-duyet-github
title: Duyet — notable GitHub projects
description: Duyet's main public repos — ClickHouse tooling, Rust data tools, AI-agent projects, infra
type: reference
category: projects
tags: [reference, duyet, github, projects]
related: ["[[user-duyet-stack]]", "[[user-duyet-ai-stance]]", "[[reference-duyet-blog]]"]
sources: ["https://github.com/duyet", "https://duyet.net/llms.txt"]
created: 2026-06-04
updated: 2026-06-14
timestamp: 2026-06-04T00:00:00Z
---

github.com/duyet — ~100 non-fork repos. Notable ones by area:

- **ClickHouse:** `clickhouse-monitoring` (flagship, ~240★, TanStack Start dashboard
  at dash.chmonitor.dev; Astro landing/docs — see [[project-clickhouse-monitor]]),
  `clickhouse-udf-rs` (Rust UDFs).
- **Rust data/infra tooling (GitOps style):** `grant-rs` (Redshift/Postgres
  privileges), `athena-rs` (AWS Athena schema), `glossary-rs` (actix API),
  `cov-rs` (coverage).
- **AI agents:** `duyetbot-agent` (TS), `coding-agent-insights` (Rust, analyzes
  coding-agent history), `ccr` (Rust, Claude Code + OpenRouter), `codex-claude-plugins`
  (Python), `okie.one` (Next.js all-in-one chat assistant).
- **Infra:** `charts` (Helm charts, tested with KinD), `gaxy` (Go GA/GTM proxy).
- **Web/personal:** `monorepo` (blog, cv, …), `api.duyet.net`, `saveto`, `feedback`.
- **Most-starred (older):** `bruteforce-database` (~1.7k★), `pricetrack` (~140★).

Languages skew Rust + TypeScript + Python. See [[user-duyet-stack]].
