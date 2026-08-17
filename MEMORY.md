# Memory Index

Master table of contents. One line per note — read this first, then open only
the notes relevant to your task. See `AGENTS.md` for the protocol.

Scope: **public, generic, durable** facts only. No secrets, hosts, or internal codenames.

## User
- [Active project portfolio (index)](memory/user/user-duyet-active-projects.md) — Index of products and repos Duyet actively builds (chmonitor, AnyRouter, OS, AgentState, AnyWorker, …)
- [AI stance (index)](memory/user/user-duyet-ai-stance.md) — How public AI practice is structured — agents over hand-writing
- [Claude Code daily driver](memory/user/user-duyet-ai-claude-code.md) — Claude Code is the stated daily coding-agent driver
- [Coding tools are disposable](memory/user/user-duyet-ai-tools-disposable.md) — Treat specific AI coding tools as replaceable; field moves fast
- [Data: ClickHouse](memory/user/user-duyet-data-clickhouse.md) — ClickHouse as primary analytics engine in public work
- [Data: Spark & Airflow](memory/user/user-duyet-data-spark-airflow.md) — Public experience with Apache Spark and Airflow
- [Duyet Le profile](memory/user/user-duyet-profile.md) — Public identity: Duyet Le (@duyet), senior data engineer
- [Focus: ClickHouse](memory/user/user-duyet-focus-clickhouse.md) — Deep public expertise and writing on ClickHouse
- [Focus: data engineering](memory/user/user-duyet-focus-data-engineering.md) — Public focus on large-scale data platforms and DE tooling
- [Focus: LLM agents](memory/user/user-duyet-focus-llm-agents.md) — Public work on coding agents, agent SDKs, RAG, agent memory
- [GitHub handle @duyet](memory/user/user-duyet-handle.md) — Public handle @duyet on GitHub and personal sites
- [Infra: Cloudflare](memory/user/user-duyet-infra-cloudflare.md) — Cloudflare Workers/Pages as primary public deploy target
- [Infra: Kubernetes](memory/user/user-duyet-infra-kubernetes.md) — Kubernetes used in public infra writing and Helm charts
- [Language: Python](memory/user/user-duyet-lang-python.md) — Python used for data eng, agents, and glue code
- [Language: Rust](memory/user/user-duyet-lang-rust.md) — Rust is a primary public language (data tooling, WASM, CLI)
- [Language: SQL](memory/user/user-duyet-lang-sql.md) — SQL is daily language for analytics and ClickHouse work
- [Language: TypeScript](memory/user/user-duyet-lang-typescript.md) — TypeScript/JavaScript for web apps and Workers
- [Local dev preferences](memory/user/user-duyet-local-dev.md) — Public local tooling: macOS, bun, uv, neovim, Obsidian
- [Multi-project builder](memory/user/user-duyet-multi-project.md) — Expect concurrent work across several public products in one session
- [Public tech stack (index)](memory/user/user-duyet-stack.md) — Index of public languages, data, infra, and AI tools
- [Runs a personal homelab](memory/user/user-duyet-homelab.md) — Duyet runs a personal homelab for self-host experiments and ops practice
- [Vibe-codes production](memory/user/user-duyet-ai-vibe-codes.md) — Public stance: agents write most production code; Markdown tops Wakatime

## Feedback
- [Cheap models for sub-agents](memory/feedback/feedback-cheap-models-subagents.md) — Fan-out sub-agents to cheaper models by default
- [Disambiguate which product/repo](memory/feedback/feedback-disambiguate-repo.md) — When the user jumps between products, confirm target repo before large edits
- [Docs-Driven Development (index)](memory/feedback/feedback-docs-driven-development.md) — Tiny router files + versioned kb brain; reflexive read/write
- [Fail loud; don't hide skips](memory/feedback/feedback-fail-loud.md) — Never claim done if tests/steps were skipped silently
- [KB is the shared brain](memory/feedback/feedback-docs-kb-is-brain.md) — Versioned, grep-able notes beat rules stuck only in prompts
- [KB stores public generic facts only](memory/feedback/feedback-public-kb-only.md) — No secrets, hosts, internal project names, or adhoc session dumps
- [Keep router files tiny](memory/feedback/feedback-docs-router-tiny.md) — CLAUDE.md/AGENTS.md = short stable rules + pointers, not architecture dumps
- [Logic change → update related tests](memory/feedback/feedback-logic-change-update-tests.md) — Co-update tests in the same change; never wait for CI
- [Never auto-merge release-please PRs](memory/feedback/feedback-never-auto-merge-release-please.md) — Leave release-please release PRs for human merge
- [Prefer simple code](memory/feedback/feedback-simple-code.md) — Minimum code that solves the problem; no speculative abstraction
- [Read MEMORY.md on entry](memory/feedback/feedback-docs-read-on-entry.md) — Before non-trivial work, read the index and relevant notes
- [Semantic commits](memory/feedback/feedback-semantic-commits.md) — Use conventional semantic commit messages
- [Surgical changes only](memory/feedback/feedback-surgical-changes.md) — Touch only what the request requires; no drive-by refactors
- [Working style (index)](memory/feedback/feedback-working-style.md) — Index of agent collaboration preferences
- [Write concise simple English](memory/feedback/feedback-concise-english.md) — Prefer short plain English in prose and commits
- [Write memory on the way out](memory/feedback/feedback-docs-write-on-exit.md) — Persist durable public facts before context is lost

## Reference
- [AI SDK UIMessage shape](memory/reference/reference-ai-sdk-uimessage.md) — UIMessage is id+role+parts; unknown part types render as null
- [Blog themes](memory/reference/reference-duyet-blog.md) — Recurring public blog themes on blog.duyet.net
- [blog.duyet.net](memory/user/user-duyet-site-blog.md) — Personal digital garden blog
- [Cloudflare acquired Astro (2026)](memory/reference/reference-cloudflare-acquires-astro.md) — Jan 2026: Astro team joined Cloudflare; Flue agent framework context
- [github.com/duyet](memory/user/user-duyet-github.md) — Public GitHub org/user for open-source work
- [homelab.duyet.net](memory/user/user-duyet-site-homelab.md) — Public homelab overview site on the personal domain
- [kb.duyet.net](memory/user/user-duyet-site-kb.md) — Public rendered face of this shared-brain repo
- [Notable public GitHub repos](memory/reference/reference-duyet-github.md) — Catalog of notable public duyet/* and related OSS repos
- [Web presence (index)](memory/user/user-duyet-web-presence.md) — Index of public sites and llms.txt sources

## Project
- [AnyRouter](memory/projects/project-anyrouter.md) — Universal multi-provider LLM API gateway at anyrouter.dev
- [AnyRouter OS](memory/projects/project-anyrouter-os.md) — Browser OS workshop at os.anyrouter.dev — AnyRouter-branded Cloudflare OS
- [AnyRouter OpenAI-compatible API](memory/projects/project-anyrouter-openai-compat.md) — Point existing OpenAI SDKs at AnyRouter base URL; swap model strings
- [AnyWorker local agent + GUI](memory/projects/project-anyworker-local-agent.md) — Product path: Python agent server plus React GUI; web is separate marketing app
- [chmonitor](memory/projects/project-clickhouse-monitoring.md) — Open-source ClickHouse operational advisor — monitoring + AI recommendations
- [chmonitor paid licenses are self-hosted host-count](memory/projects/project-chmonitor-licenses.md) — Paid chmonitor is honor-system host-count licenses (yearly/lifetime), not hosted SaaS seats
- [chmonitor recommends, never auto-DDL](memory/projects/project-chmonitor-advisor.md) — AI/ops advisor suggests CH changes but does not apply DDL automatically
- [duyet/agentstate](memory/projects/project-agentstate.md) — State and coordination layer for AI agent fleets (public OSS)
- [duyet/anyworker](memory/projects/project-anyworker.md) — Open alternative to Claude Cowork-style agents — local agent + marketing site
- [duyet/charts](memory/projects/project-charts.md) — Public Helm charts repository
- [duyet/homelab](memory/projects/project-homelab.md) — Public personal homelab repo — configs and experiments (no private topology in kb)
- [duyet/kb shared brain](memory/projects/project-kb.md) — Public shared-brain repo — atomic notes, MEMORY.md index, OKF layout
- [duyet/monorepo](memory/projects/project-monorepo.md) — Public Bun+Turborepo for personal duyet.net web apps
- [duyetbot persona](memory/projects/project-duyetbot.md) — Autonomous agent persona that maintains public monorepo within clear scope
- [KB site front-end](memory/projects/project-kb-site.md) — kb.duyet.net renders the shared-brain notes as a public site
- [Lessons — chmonitor on homelab k3s](memory/projects/homelab/lessons-chmonitor-homelab-deploy.md) — dash vs full homelab; image chmonitor org; no CH readonly profile; dedicated SELECT user + proxy auth
- [LLM Timeline](memory/projects/project-llm-timeline.md) — Public SSG timeline of LLM models at llm-timeline.duyet.net
- [Open Managed Agents (OMA)](memory/projects/project-open-managed-agents.md) — OSS self-hostable Managed Agents API — CF Workers/DO or Docker

## Tech
- [Agent-loop PR cycle](memory/topics/workflow/tech-agent-loop-cycle.md) — Periodic cycle triages open PRs and dispatches fix/review work
- [Morning Herdr issue-desk cron](memory/topics/workflow/tech-herdr-morning-issue-desk.md) — Cron starts a Grok manager on main; isolated worktrees; dated run folder left open for review
- [Agent-loop uses cheap workers](memory/topics/workflow/tech-agent-loop-cheap-subagents.md) — PR fix/review fan-out should not all run on the most expensive model
- [AgentState five primitives](memory/topics/llm-agents/tech-agentstate-five-primitives.md) — States, leases, claims, capability tokens, conversations — fleet coordination API
- [AgentState is not an agent framework](memory/topics/llm-agents/tech-agentstate-not-a-framework.md) — Coordination/state API for fleets — bring your own agent loop
- [AI agent stack map](memory/topics/llm-agents/tech-ai-agent-stack.md) — Map of common agent frameworks and what they are for
- [Cloudflare Access fails OPEN when the app is missing](memory/topics/cloudflare/tech-access-missing-app-fails-open.md) — A service-token-protected origin becomes publicly reachable if the Access application is absent
- [AI Gateway is transparent on model ids](memory/topics/cloudflare/tech-cloudflare-ai-gateway-transparent.md) — Cloudflare AI Gateway does not validate model names; upstream does
- [AI SDK native tool parts](memory/topics/llm-agents/tech-ai-sdk-uimessage-native-tools.md) — Persist or convert to dynamic-tool / tool-name parts for history reload
- [Atomic notes](memory/topics/standards/tech-note-atomic.md) — One fact per file; split when a note needs 'and'
- [Autonomous improvement loop](memory/topics/workflow/tech-improvement-loop.md) — One issue per cycle with full verify before next
- [Build-time OG images](memory/topics/web/tech-og-images-build-time.md) — Generate OG cards at build from one registry shared by generator and route head
- [BYOK sibling before disabling backend](memory/topics/llm-agents/tech-llm-gateway-byok-sibling.md) — Disabling a platform backend can silently kill BYOK that injected through it
- [Cache HIT skips Worker CPU](memory/topics/cloudflare/tech-workers-cache-hit-skips-cpu.md) — On HIT the Worker does not run — no CPU billing for that request
- [Cache-Control stale-while-revalidate](memory/topics/cloudflare/tech-workers-cache-swr.md) — SWR serves stale instantly while background refresh runs
- [Cache-Tag purge](memory/topics/cloudflare/tech-workers-cache-tags.md) — Tag responses for targeted purge instead of purge-everything
- [Chart unit suffix ≠ scale](memory/topics/standards/tech-unit-suffix-vs-scale.md) — Display unit labels must not silently convert values; pair with explicit multiplier
- [Cloudflare Pages deploy habit](memory/topics/cloudflare/tech-cloudflare-pages-deploy.md) — Semantic commit → push → deploy changed app; avoid parallel deploys that share env files
- [Codebase maintenance loop](memory/topics/workflow/tech-codebase-maintenance-loop.md) — Measure → fix top issue → verify → commit → deploy → log
- [Host cron as code](memory/topics/workflow/tech-cron-as-code-install-script.md) — Reproducible host jobs are committed crontab snippets plus an idempotent installer
- [Daily manager leaves worktrees](memory/topics/workflow/tech-daily-manager-leaves-worktrees.md) — Overnight issue-fanout persists worktrees and a dated summary for next-morning review
- [Convert history DTO → UIMessage](memory/topics/llm-agents/tech-ai-sdk-history-dto-convert.md) — Keep API neutral; translate tool-call DTOs to AI SDK parts per client
- [createContext breaks RSC importers](memory/topics/web/tech-kumo-rsc-createcontext.md) — Libraries that call createContext at module scope force client boundaries
- [Credentials never enter the sandbox](memory/topics/llm-agents/tech-oma-credentials-out-of-sandbox.md) — Managed-agent platforms should inject secrets via outbound proxy, not into the sandbox FS
- [Dashboard auth gate precedence](memory/topics/llm-agents/tech-hermes-dashboard-auth-gate.md) — Insecure/loopback allowlists can bypass OAuth if ordered wrong
- [Disk swap is not extra RAM](memory/topics/linux/tech-disk-swap-not-extra-ram.md) — A huge disk swapfile delays OOM and can hang a headless box; prefer small zram plus kill/evict
- [An unquoted shell metacharacter in a .env file silently drops every later variable](memory/topics/workflow/tech-dotenv-unquoted-value-kills-source.md) — bash source aborts at the offending line so later vars are empty
- [Filesystem-first durable agents](memory/topics/llm-agents/tech-eve-filesystem-agents.md) — Eve authors an agent as agent/ files — instructions, tools, connections
- [Eve durable runtime is Vercel or Nitro](memory/topics/llm-agents/tech-eve-runtime-vercel-nitro.md) — Eve sessions need Vercel Workflow or a self-hosted Nitro Node server
- [Flat design: hairline borders](memory/topics/web/tech-flat-design-hairline.md) — Prefer hairline borders over heavy shadows for public site UI
- [Flue: register providers in initializer](memory/topics/llm-agents/tech-flue-register-in-initializer.md) — Custom gateways must register from agent init with ctx.env; module load has empty env
- [forwardAuth must preserve status](memory/topics/cloudflare/tech-forwardauth-preserve-status.md) — Error pages middleware can rewrite 302 challenges into 401/500 and break OAuth
- [Hermes custom_providers](memory/topics/llm-agents/tech-hermes-custom-provider.md) — Register custom OpenAI-compatible providers by name, base_url, model
- [Hermes steer mode](memory/topics/llm-agents/tech-hermes-steer-mode.md) — While busy, new user messages can adjust the current task instead of being ignored
- [Note frontmatter standard](memory/topics/standards/tech-note-frontmatter.md) — Required top-level fields for every concept note
- [npx scoped package bin name](memory/topics/npm/tech-npx-scoped-package-bin.md) — npx @scope/name looks up a bin named after the last path segment
- [OG meta must be prerendered](memory/topics/web/tech-og-meta-in-prerender.md) — Social crawlers need Open Graph tags in static HTML, not only client head
- [OKF-style knowledge bundle](memory/topics/standards/tech-okf-bundle.md) — Nested markdown + frontmatter bundle with index.md and log.md
- [One codebase OSS + SaaS](memory/topics/workflow/tech-one-codebase-oss-saas.md) — Ship self-host and cloud from one tree behind a fail-closed mode flag
- [Pin GitHub Actions](memory/topics/ci/tech-pin-github-actions.md) — Pin actions to version or commit SHA; moving major tags can be force-pushed
- [Pre-1.0 feat may only bump patch](memory/topics/ci/tech-release-please-pre1-minor.md) — bump-patch-for-minor-pre-major true: feat→patch; false: feat→minor in 0.x
- [Prompt cache is byte-sensitive](memory/topics/llm-agents/tech-prompt-cache-byte-sensitive.md) — Any prefix byte change can bust LLM prompt cache
- [Qdrant HNSW config at create](memory/topics/databases/tech-qdrant-config-at-create.md) — Many collection params apply at create; retrofit via update_collection
- [Qdrant: high-dim full scan timeouts](memory/topics/databases/tech-qdrant-hnsw-timeout.md) — Large float32 collections without HNSW/quantization can time out
- [Quota errors may arrive as HTTP 400](memory/topics/llm-agents/tech-llm-gateway-quota-as-retryable.md) — Reseller budget errors buried in 400 should failover like 402/429
- [RAG citation guards](memory/topics/llm-agents/tech-rag-citation-guards.md) — URL-shaped citations can be real yet irrelevant — require passage support
- [RAG metadata key drift](memory/topics/llm-agents/tech-rag-metadata-key-drift.md) — Inconsistent metadata keys break filters between ingest and query
- [RAG: TOC docs pollute retrieval](memory/topics/llm-agents/tech-rag-toc-pollution.md) — Table-of-contents pages rank well but answer poorly — filter or downweight
- [release-please basics](memory/topics/ci/tech-release-please-basics.md) — Standing release PR + CHANGELOG; merge tags and publishes
- [Semantic design tokens](memory/topics/web/tech-flat-design-semantic-tokens.md) — Use semantic tokens (bg-card, foreground) not ad-hoc color utilities
- [shadcn/ui base components](memory/topics/web/tech-shadcn-base.md) — shadcn + CVA + slot pattern as default React component base
- [Single-source env config](memory/topics/workflow/tech-single-source-env.md) — One committed non-secret env file feeds client build and server runtime
- [Squash PR title is the release commit](memory/topics/ci/tech-release-please-pr-title.md) — Under squash-merge, PR title becomes the commit release-please reads
- [Stale route chunks after deploy](memory/topics/web/tech-tanstack-stale-chunks.md) — Missing lazy chunks throw reading 'component'; add reload guard + prerender shells
- [TanStack Start SSG](memory/topics/web/tech-tanstack-start-ssg.md) — Prerender Vite/TanStack apps to static HTML for crawlers and edge hosts
- [Tmux pane status labels](memory/topics/workflow/tech-tmux-pane-labels.md) — Map pane-current-command to short icons for agent vs editor vs idle
- [Two-phase Trivy scan](memory/topics/ci/tech-trivy-two-phase.md) — Report job always succeeds; separate fail-on-severity job gates the build
- [WASM prerender CI trap](memory/topics/web/tech-wasm-prerender-ci.md) — Missing wasm build step makes prerender succeed empty or fail late
- [When Rust WASM is worth it](memory/topics/web/tech-rust-wasm-when.md) — WASM usually wins only when the TS path is >~1ms hot work
- [Workers Cache enable flag](memory/topics/cloudflare/tech-workers-cache-enabled.md) — Enable per-worker cache with cache.enabled; only public Cache-Control is stored
- [Moving a CF zone between accounts copies DNS but not Worker routes](memory/topics/cloudflare/tech-zone-account-transfer-breaks-worker-routes.md) — Inter-account zone transfer drops Worker routes; proxied hostnames 403 Error 1000

