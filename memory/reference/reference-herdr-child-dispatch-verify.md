---
name: reference-herdr-child-dispatch-verify
title: Herdr child agents — a long prompt can fail to submit and look exactly like an idle child
description: herdr agent prompt with a long brief lands unsent in the opencode composer; verify the lifecycle moved instead of trusting the CLI's success response
type: reference
category: tooling
tags: [herdr, agents, orchestration, verification, failure-mode]
aliases: [herdr-prompt-stall, herdr-idle-child-ambiguity]
related: []
sources: []
created: 2026-09-28
updated: 2026-09-28
timestamp: 2026-09-28T09:00:00Z
---

A `herdr agent prompt` carrying a long brief (~150+ lines) can be delivered to an
opencode child's TUI as a **bracketed paste that is never submitted**. The
composer sits there showing `[Pasted ~158 lines]`, the agent stays `idle`, and
`agent prompt` still returns `{"type":"agent_prompted"}` with no error.

Short prompts of the same shape submit normally. Observed 2026-09-28 managing
docker-images worktree children.

The failure is silent because **`idle` is ambiguous**: it is the state of a child
that was never addressed *and* of one that is thinking, or done, or waiting its
turn. A manager's notes saying "Dispatched" plus a live worktree plus an idle
agent all look identical to a healthy run.

**Why:** a whole run can be lost without a single error. In that run the entire
tick reduced to one changed line, so the loss was total and the checklist still
read "Dispatched" with every box unticked.

**How to apply:**

- Put the brief in a file in the run directory (`brief-<child>.md` next to
  `queue.md`); prompt with one or two sentences plus the absolute path. Short
  prompts don't stall, and a file brief makes a re-prompt one line.
- After prompting, confirm the lifecycle actually moved:
  `herdr agent get <name>` must show `working` and a bumped `revision` within
  seconds. Unchanged `revision` means the prompt did not land.
- `herdr pane read <pane> --source visible` shows an unsent paste immediately.
- Clear a stuck composer with `herdr agent send-keys <agent> ctrl+u` before
  re-prompting, so the next submit does not concatenate with the dead paste.
- Related: a server restart can kill a child's shell tool mid-turn. Its staged
  work survives — check `git status` in its worktree before assuming a loss, then
  re-prompt; staged work only needs `git commit` and a push.
