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

## Reference
- [Web presence](memory/user/user-duyet-web-presence.md) — blog/CV/GitHub/socials + llms.txt sources
- [Blog content & themes](memory/reference/reference-duyet-blog.md) — digital garden: ClickHouse, Rust, AI agents, data eng
- [GitHub projects](memory/reference/reference-duyet-github.md) — ClickHouse tooling, Rust data tools, AI-agent repos, infra

## Project
- [ClickHouse Monitor (chmonitor)](memory/projects/project-clickhouse-monitor.md) — 4 CF workers: Astro landing/docs + TanStack dashboard + MCP; zinc/amber design system
- [duyet.net monorepo](memory/projects/project-duyet-net.md) — Bun + Turborepo, ~9 apps, TanStack Start SSG on Cloudflare Pages
- [duyetbot](memory/projects/project-duyetbot.md) — autonomous agent maintaining the monorepo: scope, loop, memory hierarchy
- [LLM Timeline app](memory/projects/project-llm-timeline.md) — 3700+ SSG pages, shadcn UI, dual data sources (1950–2026)
- [kb.duyet.net](memory/projects/project-kb-duyet-net.md) — public KB site migrating from monorepo app to this shared-brain repo
- [Infra optimization baseline](memory/projects/project-infra-optimization.md) — k3s resource tuning, security hardening, host cleanup (2026-06-13)
- [Self-driving homelab](memory/projects/homelab/project-self-driven-homelab.md) — AI agent (Minh/Hermes) manages its own k3s cluster via Telegram
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
- [Hermes agent custom provider](memory/topics/llm-agents/tech-hermes-agent-custom-provider.md) — custom_providers registration, provider:custom, steer mode
- [release-please squash pipeline](memory/topics/ci/tech-release-please-squash-pipeline.md) — squash-merge PR titles drive versioning; pre-1.0 bump trap; PR-title commitlint guard
- [Pin GitHub Actions (supply chain)](memory/topics/ci/tech-supply-chain-pin-github-actions.md) — trivy-action had 75 tags force-pushed (Mar 2026); pin Actions to SHA/version; two-phase Trivy scan (report then fail)
- [Tmux dynamic pane status labels](memory/topics/workflow/tech-tmux-pane-status-labels.md) — pane-current-command→icon mapping for agent/idle/editor at a glance; script + gpakosz automatic-rename-format
- [Open Knowledge Format (OKF)](memory/topics/standards/tech-okf-open-knowledge-format.md) — Google's open markdown+frontmatter "LLM-wiki" spec; this repo is now a strict-conformant bundle (nested topics, ISO-8601 timestamp, index.md/log.md)
- [Kumo UI + Next.js integration](memory/topics/web/tech-kumo-ui-nextjs-integration.md) — Kumo+Phosphor crash RSC via createContext (every importer "use client"); Button no render, Tabs array, no Chart; token names; Tailwind v4 @source
