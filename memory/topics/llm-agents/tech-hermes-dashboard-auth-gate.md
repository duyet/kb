---
name: tech-hermes-dashboard-auth-gate
title: Dashboard auth gate precedence
description: Insecure/loopback allowlists can bypass OAuth if ordered wrong
type: tech
category: agents
tags: [tech, llm-agents, security]
related: ["[[tech-forwardauth-preserve-status]]", "[[feedback-public-kb-only]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Generic lesson: localhost/insecure allowlists must not outrank real auth on exposed binds.

Prefer explicit bind address + auth plugin order tests. Related: [[feedback-public-kb-only]], [[tech-forwardauth-preserve-status]].
