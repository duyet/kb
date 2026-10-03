---
name: project-agentstate
title: duyet/agentstate
description: State and coordination layer for AI agent fleets (public OSS)
type: project
category: agents
tags: [project, agentstate, llm-agents, oss]
aliases: [agentstate]
related: ["[[user-duyet-active-projects]]", "[[tech-agentstate-five-primitives]]", "[[tech-agentstate-not-a-framework]]", "[[project-anyworker]]"]
sources: ["https://github.com/duyet/agentstate", "https://agentstate.app"]
created: 2026-08-10
updated: 2026-08-14
timestamp: 2026-08-14T12:00:00Z
---

github.com/duyet/agentstate · https://agentstate.app

Fleet **state/coordination** API (not an agent framework — [[tech-agentstate-not-a-framework]]). Five primitives: [[tech-agentstate-five-primitives]].

Product version is [[tech-release-please-basics]]: standing `chore(main): release X.Y.Z` PR, human-merge only ([[feedback-never-auto-merge-release-please]]). In 0.x, `feat` bumps minor (`bump-patch-for-minor-pre-major: false`). `/api` reports that semver.

**Shipping:** duyetbot auto-merges green PRs itself (merge-commit strategy that preserves the branch's semantic commits — no need to merge manually; just push, wait for CI, and confirm). Dashboard routes are auth-gated app shells, excluded from the sitemap checker.

SDKs: npm `@agentstate/sdk`, PyPI `agentstate`. MCP available. MIT, self-hostable.
Portfolio: [[user-duyet-active-projects]]. Related: [[project-anyworker]], [[project-open-managed-agents]], [[tech-ai-agent-stack]].
