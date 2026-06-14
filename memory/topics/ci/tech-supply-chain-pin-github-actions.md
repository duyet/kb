---
name: tech-supply-chain-pin-github-actions
title: Pin GitHub Actions — the trivy-action March 2026 compromise
description: aquasecurity/trivy-action had 75 tags force-pushed in March 2026 — pin Actions to a version or commit SHA and use the two-phase Trivy scan (report then fail-on-severity)
type: tech
category: security
tags: [tech, security, supply-chain, github-actions, ci, trivy]
aliases: [pin-github-actions, trivy-two-phase]
related: ["[[tech-release-please-squash-pipeline]]", "[[tech-codebase-maintenance-loop]]"]
sources: ["https://github.com/aquasecurity/trivy-action"]
created: 2026-06-10
updated: 2026-06-15
timestamp: 2026-06-10T15:43:00Z
---

GitHub Actions run with the repo's secrets, so a compromised action = a breach.
Treat every `uses:` as untrusted third-party code that executes in your CI.

## The incident

In **March 2026**, `aquasecurity/trivy-action` had **75 tags force-pushed** — a
known supply-chain attack pattern where a benign tag is silently moved to a
malicious commit. Anyone referencing `@v0.x` (a moving tag) pulled the attacker's
code on the next run. (`@v0.36.0` was the pin used here.)

## How to apply

- **Pin every Action** to a specific version tag (`@v0.36.0`, not `@v0.x`) or,
  better, a **commit SHA** (`@<sha>#semver:`). Tags can be force-pushed; SHAs
  can't (without repo history rewrite). Dependabot keeps SHA pins fresh.
- **Two-phase Trivy scan** (report, then fail) — avoids re-running the expensive
  setup and separates "show me the vulns" from "gate the build on them":
  1. **Report job** — `trivy-action` with `exit-code: 0` (always succeeds, emits
     the SARIF/JSON report).
  2. **Fail-on-severity job** — `trivy-action` with `skip-setup: true` (reuses the
     install) + `exit-code: 1` + `severity: CRITICAL,HIGH`.

Related pipeline hygiene: see [[tech-release-please-squash-pipeline]] and
[[tech-codebase-maintenance-loop]].
