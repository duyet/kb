---
name: tech-gh-token-git-host-alias
title: GitHub CLI tokens need a git host alias
description: A gh vault token keyed to api.github.com does not match github.com git remotes unless lookup aliases those hosts
type: tech
category: llm-agents
tags: [tech, agents, credentials, git, github]
aliases: [gh-git-host-alias]
related: ["[[tech-oma-credentials-out-of-sandbox]]", "[[project-open-managed-agents]]"]
sources: ["https://github.com/duyet/oma/pull/441"]
created: 2026-09-03
updated: 2026-09-03
timestamp: 2026-09-03T18:20:00Z
---

GitHub CLI (`gh`) credentials are registered for `api.github.com`. Git HTTPS remotes use `github.com` and `gist.github.com`. An exact-host vault lookup therefore misses git clones when the session only holds a `gh` token.

**Why:** `git` and `gh` are different capability specs. Adding `github.com` to the `gh` spec still loses to an exact `git` match.

**How to apply:** At lookup time, alias `github.com` / `gist.github.com` to `api.github.com` so the platform still resolves the token. Prefer exact-host credentials when both exist. Keep the token in memory; do not write it to disk, child env, or git config. Own-TLS clients (`gh`, `curl https://…`) still need a CA/MITM or a per-tool hook.

Shipped for OMA's local bridge in duyet/oma #441. Hub: [[project-open-managed-agents]]. Invariant: [[tech-oma-credentials-out-of-sandbox]].
