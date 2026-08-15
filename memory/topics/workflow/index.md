# `topics/workflow/`

## Concepts

- [Agent-loop PR cycle](tech-agent-loop-cycle.md) — Periodic cycle triages open PRs and dispatches fix/review work
- [Agent-loop uses cheap workers](tech-agent-loop-cheap-subagents.md) — PR fix/review fan-out should not all run on the most expensive model
- [Autonomous improvement loop](tech-improvement-loop.md) — One issue per cycle with full verify before next
- [Codebase maintenance loop](tech-codebase-maintenance-loop.md) — Measure → fix top issue → verify → commit → deploy → log
- [One codebase OSS + SaaS](tech-one-codebase-oss-saas.md) — Ship self-host and cloud from one tree behind a fail-closed mode flag
- [Single-source env config](tech-single-source-env.md) — One committed non-secret env file feeds client build and server runtime
- [Tmux pane status labels](tech-tmux-pane-labels.md) — Map pane-current-command to short icons for agent vs editor vs idle
- [Unquoted .env value kills source](tech-dotenv-unquoted-value-kills-source.md) — A `<` or `>` in a value aborts bash `source`, silently emptying every variable below it
