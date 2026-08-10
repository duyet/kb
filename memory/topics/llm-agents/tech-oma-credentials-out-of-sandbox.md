---
name: tech-oma-credentials-out-of-sandbox
title: Credentials never enter the sandbox
description: Managed-agent platforms should inject secrets via outbound proxy, not into the sandbox FS
type: tech
category: agents
tags: [tech, agents, security]
related: ["[[project-open-managed-agents]]", "[[feedback-public-kb-only]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Invariant for managed agent runtimes: tool sandboxes must not see raw credentials; an outbound proxy injects them.

Project: [[project-open-managed-agents]]. Related: [[feedback-public-kb-only]].
