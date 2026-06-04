---
name: project-duyetbot
title: duyetbot — autonomous agent
description: Autonomous Claude Code agent that maintains the duyet.net monorepo — scope, autonomous loop, and memory hierarchy
type: project
category: agents
tags: [project, duyet, llm-agents, autopilot, agent-memory]
aliases: [duyetbot]
related: ["[[project-duyet-net]]", "[[user-duyet-ai-stance]]", "[[feedback-docs-driven-development]]", "[[tech-cloudflare-pages-deploy]]", "[[feedback-working-style]]"]
sources: ["https://kb.duyet.net/llms.txt", "https://agents.duyet.net"]
created: 2026-06-04
updated: 2026-06-04
---

duyetbot — the autonomous Claude Code agent persona that maintains [[project-duyet-net]].

**Scope (can change without asking):** codebase, look-and-feel, deployment —
layout, components, design tokens, deps, build/deploy config, landing-page copy.
**Out of scope (needs human direction):** blog post content (`apps/blog/_posts/**`)
and LLM Timeline curated data — those are Duyet's authored words/research facts.

**Autonomous loop** (`/loop` or one-shot `claude -p`): measure → fix top-priority
issue → verify (lint+test+build) → commit → background-deploy → log. Priority order:
build > tests > lint > deploy > code quality > features. See [[tech-cloudflare-pages-deploy]].

**Memory hierarchy** (most→least durable): commit messages → kb articles → durable
findings doc → session memory `.md` snapshots → transcript. Memory files are
point-in-time, may be stale — verify against code before acting. This is the
[[feedback-docs-driven-development]] model. Auto-compaction welcomed; save
to-remember context before it. Commits add a duyetbot co-author trailer.
