---
name: project-open-managed-agents
title: Open Managed Agents (OMA)
description: OSS self-hostable Claude Managed Agents API — CF Workers/DO + self-host Node; meta-harness; pnpm monorepo; prod app.oma.duyet.net
type: project
category: project
tags: [project, cloudflare, workers, durable-objects, agents, anthropic, self-host]
aliases: [oma, open-managed-agents]
related: ["[[project-duyetbot]]", "[[tech-ai-agent-stack]]"]
sources: ["https://github.com/duyet/open-managed-agents"]
created: 2026-07-17
updated: 2026-07-17
timestamp: 2026-07-17T00:00:00Z
---

- What: open-source reimplementation of the Claude Managed Agents API. Meta-harness: platform (SessionDO Durable Object) prepares tools/skills/sandbox/credentials; a pluggable harness drives the model loop.
- Runs two ways from one business logic: Cloudflare (Workers + DO + Containers) and self-host Node (`docker compose`, `apps/main-node`). pnpm monorepo (`apps/*`, `packages/*`).
- Prod: `app.oma.duyet.net`. Deploys via GitHub Actions (`deploy-main` / `deploy-agent` / `deploy-docs` / `deploy-website` / `deploy-integrations`) on push to main, with post-deploy health assert (#245).
- CI: `typecheck` blocks PRs; 3-suite test gate (workers-pool root vitest → node-pool packages → console) blocking since #246. Local gate before push: `pnpm typecheck && pnpm test`.
- Key invariants: credentials never enter the sandbox (outbound proxy injects); prompt cache is byte-sensitive; internal packages ship raw .ts (no build).
- Maintenance style: autonomous issue runs — batch triage open issues, fix in parallel branches/worktrees, squash-merge PRs `(#NNN)`, file follow-up issues for anything found.

**Why:** recurring project — agents return to it for autonomous maintenance runs; conventions are strict and documented in-repo.
**How to apply:** read repo `CLAUDE.md` + `AGENTS.md` first; never auto-merge release-please PRs; push over HTTPS (SSH:22 blocked on this network); required boot secrets `BETTER_AUTH_SECRET` + `PLATFORM_ROOT_SECRET`.
