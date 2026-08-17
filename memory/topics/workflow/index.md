# `topics/workflow/`

## Concepts

- [Agent-loop PR cycle](tech-agent-loop-cycle.md) — Periodic cycle triages open PRs and dispatches fix/review work
- [Agent-loop uses cheap workers](tech-agent-loop-cheap-subagents.md) — PR fix/review fan-out should not all run on the most expensive model
- [An unquoted shell metacharacter in a .env file silently drops every later variable](tech-dotenv-unquoted-value-kills-source.md) — bash `source` aborts at the offending line, so variables defined after it are empty at point of use with no error — dotenv loaders parse the same file fine, which hides it
- [Autonomous improvement loop](tech-improvement-loop.md) — One issue per cycle with full verify before next
- [Codebase maintenance loop](tech-codebase-maintenance-loop.md) — Measure → fix top issue → verify → commit → deploy → log
- [Daily coding-agent manager leaves worktrees open for review](tech-daily-manager-leaves-worktrees.md) — Overnight issue-fanout should persist worktrees and a dated summary folder instead of tearing down panes
- [Host cron lives in-repo behind an install script](tech-cron-as-code-install-script.md) — Reproducible host jobs are committed crontab snippets plus an idempotent installer, not hand-edited crontab
- [Morning Herdr issue-desk cron](tech-herdr-morning-issue-desk.md) — Daily cron starts a Grok manager on main; children get isolated git worktrees; dated run folder stays on disk for review
- [One codebase OSS + SaaS](tech-one-codebase-oss-saas.md) — Ship self-host and cloud from one tree behind a fail-closed mode flag
- [Single-source env config](tech-single-source-env.md) — One committed non-secret env file feeds client build and server runtime
- [Tmux pane status labels](tech-tmux-pane-labels.md) — Map pane-current-command to short icons for agent vs editor vs idle
