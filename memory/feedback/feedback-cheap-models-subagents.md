---
name: feedback-cheap-models-subagents
title: Use cheap models for sub-agents
description: Default fan-out sub-agents/workflow agents to Sonnet or Haiku, not Opus, to control cost
type: feedback
category: workflow
tags: [feedback, agents, cost, orchestration, claude-code]
aliases: [subagent-model, cheap-subagents]
related: ["[[feedback-working-style]]"]
sources: []
created: 2026-06-06
updated: 2026-06-06
timestamp: 2026-06-06T00:00:00Z
---

When dispatching sub-agents (Agent tool) or Workflow agents — especially in
batch/parallel fan-out (e.g. babysitting/fixing/merging many PRs at once) —
default them to a **cheaper model** (`sonnet`, or `haiku` for trivial/mechanical
work) rather than inheriting Opus.

**Why:** Opus across many concurrent agents is expensive and usually overkill for
mechanical, well-scoped work (fix-CI-then-merge, search, refactor-to-spec). Duyet
flagged cost during a 13-agent parallel PR batch.

**How to apply:**
- Pass `model: "sonnet"` on `Agent` calls; `opts.model` in Workflow scripts.
- Use `haiku` for trivial/mechanical tasks; reserve **Opus** for genuinely complex
  reasoning the main loop handles.
- Don't restart already-running agents just to switch model — only apply to new
  dispatches.
