---
name: tech-flue-provider-registration
title: Flue — register model providers in the agent initializer, not module scope
description: Flue custom providers (e.g. AnyRouter) must be registered inside defineAgent's initializer using ctx.env; secrets aren't in process.env at module load
type: reference
category: llm-agents
tags: [flue, agents, anyrouter, providers, cloudflare, env, gotcha]
aliases: [flue-registerProvider, flue-anyrouter]
related: ["[[tech-oma-k3s-deploy]]", "[[tech-hermes-agent-custom-provider]]"]
sources: ["https://flueframework.com/docs/api/provider-api/"]
created: 2026-07-02
updated: 2026-07-02
timestamp: 2026-07-02T00:00:00Z
---

Flue addresses models as `provider/model`. A custom gateway (AnyRouter, OpenRouter, any OpenAI-compatible endpoint) is a provider you register with `registerProvider(id, { api:'openai-completions', baseUrl, apiKey })`. Model then = `anyrouter/stepfun-ai/step-3.7-flash` (provider id + upstream path).

**The gotcha (verified):** the API key must be a real value **at the moment `registerProvider` runs**. Flue's `getProviderApiKey` reads ONLY the registration's stored `apiKey` — no env-var fallback. And Flue does NOT populate `process.env` from `.env.local` at module-eval time:
- Node target: initializer `env` is the shell `process.env`; `.env.local` is not loaded there at all (it's a wrangler/Cloudflare mechanism).
- Cloudflare target: `.env.local` becomes the worker `env` binding, available in the initializer — not in module-scope `process.env`.

So registering in `app.ts` / module top-level with `process.env.X` gets `undefined` → runtime error `No API key for provider: <id>`.

**Fix:** register inside `defineAgent`'s initializer, from `ctx.env` (idempotent / last-write-wins, so per-init is fine):
```ts
export default defineAgent(({ env }) => {
  registerProvider('anyrouter', {
    api: 'openai-completions',
    baseUrl: 'https://anyrouter.dev/api/v1',
    apiKey: env.ANYROUTER_API_KEY,
  });
  return { model: 'anyrouter/stepfun-ai/step-3.7-flash', instructions: '...' };
});
```

**Debugging note:** the Cloudflare/workerd target swallows errors as an opaque `500 internal_error`. Reproduce with `flue run <agent> --target node` — node surfaces the real error (`No API key…`, `401 Invalid API key`, etc.). Also: `AgentRuntimeConfig` has no `output` field — structured output is per-call via `session.prompt({ result: schema })`, not an agent-level option. Channel modules (e.g. `createGitHubChannel({ webhookSecret })`) hit the same env-timing issue since they construct at module load — the secret must be present in the process env when the module evaluates.
