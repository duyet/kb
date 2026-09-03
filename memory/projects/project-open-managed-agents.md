---
name: project-open-managed-agents
title: Open Managed Agents (OMA)
description: OSS self-hostable Managed Agents API — CF Workers/DO or Docker
type: project
category: agents
tags: [project, agents, cloudflare, infra]
aliases: [oma, open-managed-agents]
related: ["[[user-duyet-active-projects]]", "[[tech-oma-credentials-out-of-sandbox]]", "[[tech-oma-bare-claude-gateway-rewrite]]", "[[tech-gh-token-git-host-alias]]", "[[tech-ai-agent-stack]]", "[[feedback-never-auto-merge-release-please]]", "[[project-oma-verify-skill]]", "[[project-oma-console-monitor]]", "[[project-oma-output-file-opt-in]]", "[[project-oma-console-hitl-approvals]]"]
sources: ["https://github.com/duyet/oma", "https://oma.duyet.net"]
created: 2026-08-10
updated: 2026-09-04
timestamp: 2026-08-10T18:00:00Z
---

github.com/duyet/oma · https://oma.duyet.net · docs: https://docs.oma.duyet.net

Open-source reimplementation of a **Managed Agents**-style API. Meta-harness: platform prepares tools/skills/sandbox/credentials; pluggable harness drives the model loop.

Runs two ways: Cloudflare (Workers + Durable Objects) or self-host Node/`docker compose` — same business logic.
Invariants: [[tech-oma-credentials-out-of-sandbox]], [[tech-prompt-cache-byte-sensitive]].
Release: [[feedback-never-auto-merge-release-please]]. Portfolio: [[user-duyet-active-projects]].

Env-fallback Claude routing: [[tech-oma-bare-claude-gateway-rewrite]].
Bridge git HTTPS with a GitHub CLI credential uses [[tech-gh-token-git-host-alias]].
Console live progress: [[project-oma-console-monitor]].
Console declared deliverables: [[project-oma-output-file-opt-in]].
HITL approvals: [[project-oma-console-hitl-approvals]].
