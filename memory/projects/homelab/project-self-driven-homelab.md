---
name: project-self-driven-homelab
title: The Self-Driving Homelab
description: self-driving k3s homelab with Hermes/Minh — an AI agent that manages its own infrastructure
type: project
category: homelab
tags: [project, homelab, k3s, ai-agents, infra]
aliases: [self-driving-homelab]
related: ["[[project-duyetbot]]", "[[tech-hermes-agent-custom-provider]]", "[[project-infra-optimization]]"]
sources: []
created: 2026-06-13
updated: 2026-06-13
timestamp: 2026-06-13T00:00:00Z
---

# The Self-Driving Homelab

A single-node k3s cluster that largely runs itself. An AI agent named Minh lives inside it, reachable by Telegram, and maintains the infrastructure it depends on.

## The Setup

**Hardware**: One machine — `duet-ubuntu`, 16 CPU, 13Gi RAM, 457G NVMe. Sitting in a home in Vietnam.

**Stack**: k3s (single-node, containerd), Traefik ingress, Let's Encrypt TLS via Cloudflare DNS-01, GitHub OAuth for auth. 15 services across 14 namespaces. All config versioned in git.

**Services**: n8n (workflows), LiteLLM (LLM proxy), Open WebUI (chat UI), Home Assistant (smart home), ClickHouse (analytics DB), Qdrant (vectors), PeerDB (CDC replication), Firecrawl (web scraping), Portainer, and others. All behind OAuth.

Nothing exotic. Standard homelab stuff. The interesting part is *who runs it*.

## Minh — The Agent That Lives Inside

Minh is an instance of [Hermes](https://github.com/duyet/charts) — an open-source AI agent framework packaged as a Helm chart. She runs as a pod in the cluster with two containers: the agent itself and a Chromium sidecar for browser automation.

**Reach**: You talk to Minh via Telegram (`@minh_duni_bot`). She speaks Vietnamese by default, switches to English when you write in English. One language per reply.

**Brain**: Backed by `@preset/hermes-agent` through [AnyRouter](https://anyrouter.dev), with fallback to Gemini Flash and Claude Sonnet via OpenRouter. She has persistent memory (SOUL.md + session state on a PVC), so she remembers conversations and learns preferences.

**Tools**: MCP servers give her filesystem access, web fetch, GitHub (official github-mcp-server), n8n workflow management, and browser automation via CDP. She can scrape the web (self-hosted Firecrawl), search (Tavily), read email (Himalaya + Gmail), and manage GitHub repos.

**Personality**: Warm, concise, witty. Evidence over guesses. Honest about uncertainty. Proactive with obvious next steps. Calls the user "anh Duyệt" and refers to herself as "em" — Vietnamese familiar pronouns.

## The Self-Management Loop

Here's where it gets recursive. Minh has **cluster-admin** RBAC and the IaC repos (`duyet/infra`, `duyet/charts`) are mounted directly into her pod via hostPath. She can:

1. **Read the cluster state** — `kubectl get pods -A`, `helm list`, check PVCs, view logs
2. **Edit the infrastructure code** — modify `values.yaml`, manifests, secrets
3. **Deploy changes** — `helm upgrade --install`, `kubectl apply`
4. **Commit and push** — git commit with semantic messages, push to GitHub
5. **Verify** — check pod health, test HTTP endpoints, confirm data integrity
6. **Update herself** — even `helm upgrade hermes` to change her own deployment

This is the full GitOps loop, but the agent *is* the operator. No ArgoCD. No Flux. Just an LLM with kubectl and a git client.

### Example Workflows

- **"The site is down"** → Minh checks pods, finds a crash, reads logs, identifies the config error, edits values.yaml, runs helm upgrade, verifies pods are Running, commits the fix.
- **"Add a new service"** → Minh creates the namespace directory, writes values.yaml + secrets template, runs helm install, creates the ingress, tests the endpoint, updates docs.
- **"How much disk do we have?"** → Zero-token shortcut command, instant response with `df -h` output.
- **"Optimize resources"** → Minh profiles actual CPU/memory usage across all pods, compares to configured limits, adjusts requests/limits in all values files, deploys everything, verifies health, commits. (This actually happened — [[project-infra-optimization]])

### Quick Commands

Minh has 9 pre-built zero-token shortcuts for common ops: `k3s-status`, `k3s-nodes`, `top`, `disk`, `mem`, `uptime`, `helm`, `pvc`, `infra-diff`. These bypass the LLM entirely — instant shell output.

## Security Model

Yes, a Telegram-reachable LLM with cluster-admin is a high blast radius. This is intentional for a single-node, single-user homelab. Mitigations:

- **`approvals: smart`** — Minh asks for confirmation before destructive operations (delete namespace, wipe PVC, `--force`)
- **Persona guardrails** — her SOUL.md explicitly forbids destructive commands without confirmation
- **GitHub App auth** — uses a short-lived installation token (60min), not a personal token
- **OAuth everywhere** — all services behind GitHub OAuth via Traefik forwardAuth
- **HostPath limitation** — ties the pod to one node. Acceptable for a homelab; multi-node would need RWX PVC or GitOps

## What I Learned

**Resource tuning is an LLM superpower**. Profiling 40+ pods, comparing actual vs configured resources, and adjusting 14 services in parallel is exactly the kind of tedious, systematic work agents excel at. The optimization pass freed 1.7Gi RAM and 9GB disk in one shot.

**Self-reference is stable**. An agent managing its own deployment sounds like it should break, but in practice it's fine — Helm handles rolling updates, and the pod finishes its work before the new one takes over.

**HostPath is the real constraint**. The IaC repos being mounted from the host means this pattern is single-node only. For multi-node, you'd need git-clone init containers or a proper GitOps tool.

**Kubernetes is good infrastructure for agents**. RBAC, PVCs, init containers, health probes — all the K8s primitives that manage the agent also give it a rich environment to work with. The agent doesn't need special tooling; it just needs kubectl and helm.

## Architecture

```
User (Telegram)
    ↓
Minh (@minh_duni_bot)
    ↓ (LLM: @preset/hermes-agent via AnyRouter)
Hermes Pod (k3s, namespace: hermes-agent)
    ├── agent container (hermes-agent)
    │   ├── MCP: filesystem, fetch, time, github, n8n
    │   ├── kubectl + helm (cluster-admin SA)
    │   ├── hostPath: ~/project/infra, ~/project/charts
    │   └── git (GitHub App duyetbot, 60min tokens)
    └── chromium container (CDP :9222)
         ↓
    k3s API → manages all namespaces
    GitHub API → commits IaC changes
```

## Related

- [[project-infra-optimization]] — the resource optimization pass Minh performed
- [[tech-traefik-forwardauth-oauth2-proxy]] — auth layer protecting all services
- [[tech-hermes-agent-custom-provider]] — custom LLM provider registration

## Links

- Hermes chart: [github.com/duyet/charts/hermes-agent](https://github.com/duyet/charts)
- Infra repo: [github.com/duyet/infra](https://github.com/duyet/infra)
- Hermes agent framework: [github.com/nicepkg/hermes](https://github.com/nicepkg/hermes)
