---
name: project-aidr-cf-cli
title: aidr uses the cf CLI for D1 and secrets
description: aidr.today keeps wrangler.toml and wrangler deploy because cf migrate drops Workflows and Durable Objects.
type: project
category: infra
tags: [aidr, cloudflare, cf, wrangler]
aliases: []
related: []
sources: ["https://blog.cloudflare.com/cloudflare-cf-cli-launch/"]
created: 2026-09-29
updated: 2026-09-29
timestamp: 2026-09-29T00:00:00Z
---

aidr (`apps/web`, Worker `aidr`) uses the `cf` CLI (1.0.0-beta.5) for D1 and Worker secrets.

- D1 database id: `0c8f3efe-0427-4268-8d9f-bb1a4bcbe427`. Commands take the id, not the name `aidr`.
- Migrations: `cf d1 migrations apply 0c8f3efe-0427-4268-8d9f-bb1a4bcbe427 --dir migrations`
- Query: `cf d1 query <id> --sql "..."`
- Secrets: `cf workers secrets bulk --worker aidr --file <json array of {name,text,type}>`
- Deploy stays `wrangler deploy --config dist/server/wrangler.json`. `cf migrate` does not carry the `news-ingest` Workflow or the `NewsIngestScheduler` Durable Object.

**Why:** the hourly ingest depends on those bindings.
**How to apply:** do not replace `wrangler.toml` with `cloudflare.config.ts` until `cf migrate` keeps Workflows and Durable Objects.
