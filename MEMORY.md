# Memory Index

Master table of contents. One line per note — read this first, then open only
the notes relevant to your task. See `AGENTS.md` for the protocol.

## User
- [Duyet Le profile](memory/user/user-duyet-profile.md) — senior data engineer (VN), owner of this brain
- [Tech stack](memory/user/user-duyet-stack.md) — Rust/Python/TS/SQL, ClickHouse, K8s, data + LLM agents
- [AI & coding-agent stance](memory/user/user-duyet-ai-stance.md) — vibe-codes prod, Claude Code daily driver, agent SDKs

## Feedback
- [Working style](memory/feedback/feedback-working-style.md) — concise English, simple code, semantic commits
- [Docs-Driven Development](memory/feedback/feedback-docs-driven-development.md) — tiny router + kb brain, auto read-in/write-out
- [Cheap models for sub-agents](memory/feedback/feedback-cheap-models-subagents.md) — default fan-out agents to Sonnet/Haiku, not Opus, to control cost
- [Logic change → update related tests](memory/feedback/feedback-logic-change-update-related-tests.md) — same change greps/updates related tests; never wait for CI

## Reference
- [Web presence](memory/user/user-duyet-web-presence.md) — blog/CV/GitHub/socials + llms.txt sources
- [Blog content & themes](memory/reference/reference-duyet-blog.md) — digital garden: ClickHouse, Rust, AI agents, data eng
- [GitHub projects](memory/reference/reference-duyet-github.md) — ClickHouse tooling, Rust data tools, AI-agent repos, infra
- [Cloudflare acquired Astro](memory/reference/reference-cloudflare-acquires-astro.md) — Jan 2026; Astro team (Fred Schott) now at CF, ships Flue agent framework
- [AI SDK history → UIMessage mapping](memory/reference/reference-ai-sdk-history-uimessage-mapping.md) — persisted tool/chart parts vanish on reload unless translated to native dynamic-tool shape

## Project
- [ClickHouse Monitor (chmonitor)](memory/projects/project-clickhouse-monitor.md) — 7 CF workers (dashboard/landing/docs/blog/mcp/bug-handler/cloud-hooks); pnpm not bun; Cloud SaaS live (Clerk+D1+Polar); AI agent + alerting; in-repo docs/knowledge graph
- [chmonitor — one codebase OSS + Cloud SaaS](memory/projects/project-chmonitor-one-codebase-saas.md) — CHM_DEPLOYMENT_MODE fail-closed to OSS; single-source .env pattern keeps Wrangler/Docker/K8s in sync
- [duyet.net monorepo](memory/projects/project-duyet-net.md) — Bun + Turborepo, ~9 apps, TanStack Start SSG on Cloudflare Pages
- [duyetbot](memory/projects/project-duyetbot.md) — autonomous agent maintaining the monorepo: scope, loop, memory hierarchy
- [Open Managed Agents (OMA)](memory/projects/project-open-managed-agents.md) — OSS Claude Managed Agents API reimpl; CF Workers/DO + self-host Node; prod app.oma.duyet.net; autonomous issue-run maintenance
- [LLM Timeline app](memory/projects/project-llm-timeline.md) — 3700+ SSG pages, shadcn UI, dual data sources (1950–2026)
- [kb.duyet.net](memory/projects/project-kb-duyet-net.md) — public KB site migrating from monorepo app to this shared-brain repo
- [Infra optimization baseline](memory/projects/project-infra-optimization.md) — k3s resource tuning, security hardening, host cleanup (2026-06-13)
- [Self-driving homelab](memory/projects/homelab/project-self-driven-homelab.md) — AI agent (Minh/Hermes) manages its own k3s cluster via Telegram
- [ClickHouse instance roles & tuning](memory/projects/homelab/reference-clickhouse-machines.md) — three self-hosted instances by role; memory-tuning + clone lessons (non-identifying)
- [Session — ClickHouse multi-host setup](memory/projects/homelab/sessions/2026-06-30-clickhouse-machines-setup.md) — connectivity fixes, memory optimization, cross-host clone of an analytics DB
- [AnyRouter](memory/projects/project-anyrouter.md) — LLM API gateway on CF Workers; TanStack Start + Kumo; split web/API workers; prerendered marketing shells

## Tech
- [AI agent stack](memory/topics/llm-agents/tech-ai-agent-stack.md) — LangGraph/AI SDK/Agents SDK/MCP + what Duyet uses
- [eve framework](memory/topics/llm-agents/tech-eve-framework.md) — Vercel filesystem-first durable agents; file layout, MCP connections, the Node-24 .ts-import gotcha
- [TanStack Start SSG](memory/topics/web/tech-tanstack-start-ssg.md) — prerender Vite app to survive CF Rocket Loader; migration recipe
- [Per-page OG images (static prerender)](memory/topics/web/tech-og-images-static-prerender.md) — build-time Satori cards from one registry feeding generator + route head; meta must be in prerendered HTML for crawlers
- [TanStack stale route chunks](memory/topics/web/tech-tanstack-stale-route-chunks.md) — missing lazy chunks → reading 'component'; reload guard + prerender shells
- [Rust→WASM strategy](memory/topics/web/tech-rust-wasm-prerender.md) — WASM only beats TS >1ms; the silent-prerender CI trap
- [Flat design system](memory/topics/web/tech-flat-design-system.md) — hairline borders, lucide, shadcn + semantic tokens, dark mode
- [Cloudflare Pages deploy](memory/topics/cloudflare/tech-cloudflare-pages-deploy.md) — commit→push→background-deploy; parallel-deploy hazard
- [Codebase maintenance loop](memory/topics/workflow/tech-codebase-maintenance-loop.md) — improvement cycles, safe dead-code removal, tests
- [Agent-loop autonomous PR management](memory/topics/workflow/tech-agent-loop-autonomous-pr-management.md) — 15-min cycle triages all PRs, cheap subagents fix/review/merge, reduces context overhead
- [Cloudflare AI Gateway proxy](memory/topics/cloudflare/tech-cloudflare-ai-gateway-proxy.md) — AIG doesn't validate model ids; "invalid model ID" is the upstream rejecting, not CF
- [Traefik forwardAuth + OAuth2 Proxy](memory/topics/cloudflare/tech-traefik-forwardauth-oauth2-proxy.md) — ErrorPages keeps original status, need nginx redirector for 302
- [Cloudflare Workers Cache](memory/topics/cloudflare/tech-cloudflare-workers-cache.md) — per-worker tiered cache in front of the Worker; `cache.enabled` + `Cache-Control`/SWR/`Cache-Tag`; HIT skips Worker (0 CPU), authed requests auto-bypass
- [Hermes agent custom provider](memory/topics/llm-agents/tech-hermes-agent-custom-provider.md) — custom_providers registration, provider:custom, steer mode
- [Hermes dashboard auth gate](memory/topics/llm-agents/tech-hermes-dashboard-auth.md) — nous OAuth plugin, insecure/loopback gate precedence, localhost-allowlist gotcha
- [release-please squash pipeline](memory/topics/ci/tech-release-please-squash-pipeline.md) — squash-merge PR titles drive versioning; pre-1.0 bump trap; PR-title commitlint guard
- [Pin GitHub Actions (supply chain)](memory/topics/ci/tech-supply-chain-pin-github-actions.md) — trivy-action had 75 tags force-pushed (Mar 2026); pin Actions to SHA/version; two-phase Trivy scan (report then fail)
- [Tmux dynamic pane status labels](memory/topics/workflow/tech-tmux-pane-status-labels.md) — pane-current-command→icon mapping for agent/idle/editor at a glance; script + gpakosz automatic-rename-format
- [Open Knowledge Format (OKF)](memory/topics/standards/tech-okf-open-knowledge-format.md) — Google's open markdown+frontmatter "LLM-wiki" spec; this repo is now a strict-conformant bundle (nested topics, ISO-8601 timestamp, index.md/log.md)
- [Kumo UI + Next.js integration](memory/topics/web/tech-kumo-ui-nextjs-integration.md) — Kumo+Phosphor crash RSC via createContext (every importer "use client"); Button no render, Tabs array, no Chart; token names; Tailwind v4 @source
- [Qdrant HNSW + quantization tuning](memory/topics/databases/tech-qdrant-hnsw-tuning.md) — why 4096-d collections time out (full scan over float32); fix = tuned HNSW + INT8 quantization; config only applies at create, retrofit via update_collection
- [Flue provider registration timing](memory/topics/llm-agents/tech-flue-provider-registration.md) — register custom gateways (AnyRouter) in the agent initializer from ctx.env; process.env is empty at module load; workerd hides errors, use --target node
- [OMA on k3s via ArgoCD](memory/topics/homelab/tech-oma-k3s-deploy.md) — deploy + drive self-hosted Open Managed Agents; verified run flow; BYOK model card → AnyRouter; self-host bugs (model_cards write path, uncapped max_tokens)
- [Lessons — OMA self-host deploy](memory/topics/homelab/lessons-oma-selfhost-deploy.md) — what bit us: main-node ≠ main (stubbed routes), BYOK+4096-tokens→502, pnpm v11 strictDepBuilds CI break, ConfigMap needs rollout restart
- [RAG retrieval pollution](memory/topics/llm-agents/tech-rag-retrieval-pollution.md) — TOC docs poison vector search; citation guards pass real-but-irrelevant URLs; metadata key drift; registry embed model
- [Unit suffix vs scale](memory/topics/standards/tech-unit-suffix-vs-scale.md) — chart units never convert, pair with explicit multiplier; impossible-60-minutes formatter diagnostic
