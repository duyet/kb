---
name: tech-dotenv-unquoted-value-kills-source
title: An unquoted shell metacharacter in a .env file silently drops every later variable
description: bash `source` aborts at the offending line, so variables defined after it are empty at point of use with no error — dotenv loaders parse the same file fine, which hides it
type: reference
category: workflow
tags: [reference, shell, bash, dotenv, debugging, gotcha]
aliases: ["source .env silently fails", "env vars empty after sourcing"]
related: ["[[tech-access-missing-app-fails-open]]"]
sources: []
created: 2026-08-16
updated: 2026-08-16
timestamp: 2026-08-16T00:00:00Z
---

`set -a; source .env` is a common way to load config into a shell. It parses as
**shell code**, not as a config format, so a value containing an unquoted
metacharacter (`<` `>` `|` `&` `;` `(` `)`) is a syntax error:

```
NAME=Some Product <noreply@example.com>
    -> syntax error near unexpected token `newline'
```

**The damage is everything below it.** `source` aborts at that line, so every variable
defined *after* it is never set. There is no error at the point of use — the variable
is simply empty, and a script continues with a blank URL, host, or password.

**Why it survives for months:** dotenv-style loaders (Node, Python, Vite, wrangler)
tokenize line-by-line and handle the same file without complaint. Only the shell path
breaks, so it fails for scripts and CI steps while the application works fine.

Detect it — the error goes to stderr and is easy to swallow:

```
set -a; source .env            # do NOT redirect stderr away
grep -nE '^[A-Z_]+=[^"'"'"']*[<>|&;()]' .env      # find unquoted offenders
```

Fix by quoting the value. Prefer quoting **every** value in files that anything
sources.

Two related traps:
- `source` inside a pipeline (`source .env | head`) runs in a subshell, so the
  variables vanish before the next command — a test harness bug that looks identical
  to the real failure.
- This is the same family as a database client accepting an empty connection string
  and reporting success: the failure is the *absence* of a value, so nothing throws.
