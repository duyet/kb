---
name: project-open-managed-agents
title: Open Managed Agents (OMA)
description: OSS self-hostable Managed Agents API — CF Workers/DO or Docker
type: project
category: agents
tags: [project, agents, oma, cloudflare, self-host]
aliases: [oma, open-managed-agents]
related: ["[[user-duyet-active-projects]]", "[[tech-oma-credentials-out-of-sandbox]]", "[[tech-ai-agent-stack]]", "[[feedback-never-auto-merge-release-please]]"]
sources: ["https://github.com/duyet/oma", "https://oma.duyet.net"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T18:00:00Z
---

github.com/duyet/oma · https://oma.duyet.net · docs: https://docs.oma.duyet.net

Open-source reimplementation of a **Managed Agents**-style API. Meta-harness: platform prepares tools/skills/sandbox/credentials; pluggable harness drives the model loop.

Runs two ways: Cloudflare (Workers + Durable Objects) or self-host Node/`docker compose` — same business logic.
Invariants: [[tech-oma-credentials-out-of-sandbox]], [[tech-prompt-cache-byte-sensitive]].
Release: [[feedback-never-auto-merge-release-please]]. Portfolio: [[user-duyet-active-projects]].
