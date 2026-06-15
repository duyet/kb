---
name: tech-tmux-pane-status-labels
title: Tmux dynamic pane status labels
description: Tmux automatic-rename-format using pane_current_command icons to distinguish active coding agents from idle shells at a glance
type: tech
category: workflow
tags: [tmux, workflow, tooling, terminal]
related: ["[[tech-agent-loop-autonomous-pr-management]]"]
sources: []
created: 2026-06-15
updated: 2026-06-15
timestamp: 2026-06-15T14:30:00Z
---

## Problem

When running multiple tmux windows with coding agents, you can't tell at a glance which tabs have an active agent session vs which are sitting idle at a shell prompt waiting for human review.

## Solution

Create a `~/.local/bin/tmux-pane-label` script that maps `#{pane_current_command}` to a descriptive icon+label, then wire it into tmux's `automatic-rename-format`.

### Script location

`~/.local/bin/tmux-pane-label` (chmod +x, must be in `$PATH`)

### Command → label mapping

| Command | Tab label | Meaning |
|---|---|---|
| `opencode`, `claude`, `codex`, `cursor` | `⟳ name` | Agent actively running |
| `bash`, `sh`, `zsh`, `fish` | `⌄ name` | Idle at shell prompt |
| `nvim`, `vim`, `nano` | `✎ name` | Editor open |
| `node`, `npm`, `bun`, `deno` | `⚡ name` | Dev tool running |
| `python`, `python3` | `🐍 python` | Python process |
| `ssh` | `🌐 ssh` | Remote session |
| `htop`, `top`, `btm` | `📊 name` | System monitor |
| `docker` | `🐳 docker` | Container tool |
| `sudo` | `🔒 sudo` | Privileged command |
| `make`, `cargo`, `go` | `🔨 name` | Build tool |
| `less`, `more`, `man` | `📄 name` | Pager |
| `tail`, `tailf`, `watch` | `📋 name` | Log follow |
| `tmux` | `⏎` | Tmux internal |
| anything else | raw command name | Fallback |

### Tmux config (`~/.tmux.conf.local` for gpakosz/.tmux)

```tmux
set -g automatic-rename-format \
  "#{?pane_in_mode,[tmux],#(tmux-pane-label #{pane_id})}#{?pane_dead,[dead],}"

# ⌃b + Shift+R re-enables dynamic naming on a manually-renamed window
bind R set-window-option automatic-rename on \; display "Dynamic naming ON"
```

### How it works

- `automatic-rename-format` dynamically sets window names based on the active pane
- The script calls `tmux display -t <pane_id> -p '#{pane_current_command}'` and classifies the result
- When a coding agent is the foreground process, the tab shows "⟳ agentname"
- When the agent exits and the shell returns, the tab switches to "⌄ bash"
- Previously renamed windows (`automatic-rename off` per-window) keep static names
- **⌃b + Shift+R** re-enables dynamic naming on per-window basis

### Notes

- Script must handle panes that no longer exist (`tmux display` fails → returns `"?"`)
- The `#()` format expansion is fast (<10ms per call, runs per status-interval)
- Manual window names (via `⌃b + ,`) take precedence and disable automatic-rename
- Tested with tmux 3.6a and gpakosz/.tmux config framework
