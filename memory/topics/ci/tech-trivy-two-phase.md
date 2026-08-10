---
name: tech-trivy-two-phase
title: Two-phase Trivy scan
description: Report job always succeeds; separate fail-on-severity job gates the build
type: tech
category: ci
tags: [tech, ci, security, trivy]
related: ["[[tech-pin-github-actions]]", "[[tech-codebase-maintenance-loop]]"]
created: 2026-08-10
updated: 2026-08-10
timestamp: 2026-08-10T12:00:00Z
---

Phase 1: scan with exit 0 for artifacts. Phase 2: fail on CRITICAL/HIGH, ideally reusing setup.

Related: [[tech-pin-github-actions]], [[tech-codebase-maintenance-loop]].
