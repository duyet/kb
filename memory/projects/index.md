# `projects/`

## Groups

- [`homelab/`](homelab/)

## Concepts

- [AnyRouter](project-anyrouter.md) — Universal multi-provider LLM API gateway at anyrouter.dev
- [AnyRouter CLI is a native Rust binary](project-anyrouter-cli-native.md) — Public install is curl | bash; binary is anyr; pin models with anyr claude --model owner/model
- [AnyRouter OpenAI-compatible API](project-anyrouter-openai-compat.md) — OpenAI-shaped clients; text and embeddings only — image/video generation is gone
- [AnyRouter OS](project-anyrouter-os.md) — Browser OS workshop — repo duyet/anyrouter-os; file bugs on duyet/anyrouter with [os] prefix
- [AnyRouter playground MCP](project-anyrouter-playground-mcp.md) — Playground new chats enable AnyRouter MCP at the documented HTTP endpoint
- [AnyRouter public UI chrome](project-anyrouter-ui-chrome.md) — Viewport tokens, 44px targets, semantic dark, compact playground row
- [AnyWorker local agent + GUI](project-anyworker-local-agent.md) — Product path: Python agent server plus React GUI; web is separate marketing app
- [chmonitor](project-clickhouse-monitoring.md) — Open-source ClickHouse operational advisor — monitoring + AI recommendations
- [chmonitor CLI local named connections](project-chmonitor-cli-local-connections.md) — chm add/ls/use/rm save local ClickHouse HTTP and postgres:// connections; secrets stay in the credentials helper
- [chmonitor hide sidebar pages in place](project-chmonitor-hide-menu-item.md) — Hover Hide next to pin hides a sidebar leaf; restore in Settings → Workspace → Navigation
- [chmonitor menu engine filter](project-chmonitor-menu-engine-filter.md) — Absent engines on a menu item means ClickHouse family; Postgres hosts must not see those items
- [chmonitor paid licenses are self-hosted host-count](project-chmonitor-licenses.md) — Paid chmonitor is honor-system host-count licenses (yearly/lifetime), not hosted SaaS seats
- [chmonitor recommends, never auto-DDL](project-chmonitor-advisor.md) — AI/ops advisor suggests CH changes but does not apply DDL automatically
- [chmonitor Tools sidebar group](project-chmonitor-tools-sidebar.md) — Dashboard Tools group holds SQL Console, Data Explorer, Explain, Advisor, Chart Builder, Schema Compare, Settings Diff
- [chmonitor TTL & Partitions inventory](project-chmonitor-ttl-partitions.md) — System TTL page lists table inventory plus part-health charts; never select system.tables.ttl
- [chmonitor verify skill](project-chmonitor-verify-skill.md) — Project-local .cursor/skills/verify-chmonitor drives the Rust CLI; default doctor is identity-only
- [codex-claude-plugins verify skill](project-codex-claude-plugins-verify-skill.md) — Project-local .cursor/skills/verify-marketplace; CLI lever on catalogs/manifests, not a hosted UI
- [duyet/agentstate](project-agentstate.md) — State and coordination layer for AI agent fleets (public OSS)
- [duyet/anyworker](project-anyworker.md) — Open alternative to Claude Cowork-style agents — local agent + marketing site
- [duyet/charts](project-charts.md) — Public Helm charts repository
- [duyet/homelab](project-homelab.md) — Public personal homelab repo — configs and experiments (no private topology in kb)
- [duyet/kb shared brain](project-kb.md) — Public shared-brain repo — atomic notes, MEMORY.md index, OKF layout
- [duyet/monorepo](project-monorepo.md) — Public Bun+Turborepo for personal duyet.net web apps including news and the kb site
- [duyetbot persona](project-duyetbot.md) — Manager agent for the public product fleet — assigns work, keeps kb current
- [KB site front-end](project-kb-site.md) — kb.duyet.net renders the shared-brain notes; apps/kb/kb mounts ~/kb
- [LLM Timeline](project-llm-timeline.md) — Public SSG timeline of LLM models at llm-timeline.duyet.net
- [news.duyet.net](project-news.md) — Personal news feed + public digest; homepage AI;DR thumbs; news-tab own 0.1.x release line
- [oma verify skill](project-oma-verify-skill.md) — Project-local .cursor/skills/verify-oma with control-oma.mjs CLI lever and Feature Map for web + Console
- [One AnyRouter listing id per model](project-anyrouter-catalog-one-id.md) — Catalog id is owner/model; host SKUs (date, vision-exp, fast, casing) are upstream names or aliases
- [Open Managed Agents (OMA)](project-open-managed-agents.md) — OSS self-hostable Managed Agents API — CF Workers/DO or Docker
- [templatebot pay-to-install Sale listings](project-templatebot-pay-to-install.md) — Sale templates require checkout before install; delivery is email plus secret unlock URL; owners see 5% platform fee plus processor estimate and net
- [templatebot verify skill](project-templatebot-verify-skill.md) — Project-local .cursor/skills/verify-templatebot drives the Vite marketplace over CDP; Feature Map includes browse card coat blend, unlisted /data analytics, PostHog funnel, marquee, pay-to-install, MCP publish, viewport presets
- [Unlist broken AnyRouter models](project-anyrouter-unlist-broken-models.md) — Disable or unlist a broken model from /models and the catalog; do not delete history
