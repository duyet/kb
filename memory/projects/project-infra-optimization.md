---
name: project-infra-optimization
title: Infra Optimization Baseline (2026-06-13)
description: k3s cluster resource optimization, security hardening, and host cleanup — baseline for future tuning
type: project
category: infra
tags: [project, infra, k3s, homelab, optimization]
aliases: []
related: ["[[project-self-driven-homelab]]"]
sources: []
created: 2026-06-13
updated: 2026-06-13
timestamp: 2026-06-13T00:00:00Z
---

# Infra Optimization Baseline (2026-06-13)

**Goal**: optimize resources, reduce complexity, fix security issues on duet-ubuntu k3s cluster.

## Results

| Metric | Before | After | Delta |
|--------|--------|-------|-------|
| Memory | 10Gi (78%) | 9.2Gi (70%) | **-1.7Gi** |
| Disk | 372G (86%) | 363G (84%) | **-9GB** |
| Swap files | 2 (16G) | 1 (11G) | -4G file |
| CrashLoop pods | 1 | 0 | fixed |
| Services without limits | cert-manager | 0 | all limited |
| Kubeconfig perms | 644 world-readable | 640/600 | secured |

## What Changed

### Resource optimization (all services)
- Key principle: set requests based on actual usage, limits at 1.5-2x peak
- Hermes: memory limit raised 1Gi → 2Gi (was being exceeded at 1212Mi)
- PeerDB: massive over-provisioning fixed — temporal 512→128Mi, flow-worker 512→128Mi, total req ~1.9Gi → 736Mi
- Home Assistant: CPU limit 2 → 500m (only using 10m actual)
- Open-WebUI: memory limit 1536Mi → 1Gi, CPU limit 1 → 500m
- LiteLLM: memory limit 1536 → 1200Mi
- ClickHouse: memory limit 2Gi → 1536Mi, CPU limit 1 → 500m
- n8n + worker: memory limits 1Gi → 512Mi
- Portainer, Qdrant, Promptfoo, Vito, Chmonitor: all tightened
- cert-manager: added limits to all 3 components (previously unlimited)

### Security
- Kubeconfig: `/etc/rancher/k3s/k3s.yaml` mode 640, user copy `$HOME/.kube/config.duet-homelab` mode 600
- All Makefiles and docs updated to use new KUBECONFIG path
- Docker daemon stopped, disabled, masked (k3s uses containerd)

### Host cleanup
- Journal logs vacuumed 876MB → 100MB cap
- Old kernel 6.8.0-110-generic removed
- Swap consolidated: removed `/swap.img` (4G), kept `/swapfile2` (11G)
- Failed systemd units masked: NetworkManager-wait-online, systemd-networkd-wait-online

### Firecrawl fix
- nuq-worker disabled (CrashLoopBackOff — missing NUQ cloud config, not needed for homelab)
- Added `{{- if .Values.nuqWorker.enabled }}` guard to deployment template

## Repo: `~/project/infra` (duyet/infra)

**Why**: baseline for future optimization rounds. Re-run `kubectl top pods -A` to compare.
**How to apply**: resource tuning is iterative — always measure actual usage before adjusting.
