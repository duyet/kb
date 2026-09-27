---
name: project-anyrouter-uniform-reasoning
title: AnyRouter should unify reasoning effort across upstreams and models
description: Ticket — /api/v1/models advertises reasoning params on 12 of 206 listings, never the accepted effort values, so clients cannot discover a uniform reasoning surface
type: project
category: llm
tags: [project, anyrouter, llm, gateway, api, reasoning]
aliases: [anyrouter-uniform-reasoning, anyrouter-reasoning-ticket]
related: ["[[project-anyrouter]]", "[[project-anyrouter-openai-compat]]", "[[project-anyrouter-catalog-one-id]]"]
sources: ["https://anyrouter.dev/api/v1/models?all=1", "https://docs.anyrouter.dev/features/models-catalog"]
created: 2026-09-27
updated: 2026-09-27
timestamp: 2026-09-27T09:30:00Z
---

Open ticket for [[project-anyrouter]], measured on the full catalog
(`GET /api/v1/models?all=1`, 206 listings, 2026-09-27). AnyRouter is one
gateway over many upstreams, so it should expose **one** reasoning contract
instead of whatever each upstream happens to accept.

Evidence:

- 123 listings carry `reasoning` in `capabilities`, but only **12** list any
  reasoning request field in `supported_parameters`.
- Those 12 disagree with each other: `inclusionai/ling-3.0-flash-fin` and
  `nex-agi/nex-n2.5-*` list only `reasoning`; `z-ai/glm-4.5` and
  `z-ai/glm-5.2` list only `reasoning_effort`; only `z-ai/glm-5.3-flash` and
  `stealth/space-bunny-alpha` list all three.
- **No listing ever publishes the accepted effort values.** A client cannot
  tell whether `xhigh` is legal on a given route.
- All 9 `anyrouter/*` presets advertise only
  `[max_tokens, temperature, top_p, stop, stream]` — no reasoning and no
  `tools` — even though `auto`/`hermes`/`cowork` route to reasoning models
  and the preset descriptions tell callers to pass `tools`.
- 101 of 206 listings have `top_provider.max_completion_tokens: null`, so the
  documented clamp ("A max_tokens set higher is clamped down silently") is
  undiscoverable. `anyrouter/decision` is one of them.

Asks:

1. One reasoning surface for the whole API: the same request field
   (`reasoning` + `reasoning_effort`) accepted on every model, forwarded to
   whichever route serves the request.
2. Publish the accepted effort values per model, or adopt a single ladder
   (`low`/`medium`/`high`) and document it once.
3. Include reasoning and `tools` in the presets' `supported_parameters`.
4. Fill `top_provider.max_completion_tokens` (or add an explicit
   `max_output_tokens`) so the clamp is discoverable.

**Why:** without this, every client maintains its own per-model reasoning
table and guesses. AnyRouter's gateway already hides upstream differences, so
the reasoning contract should be hidden the same way.
**How to apply:** no public tracker exists for AnyRouter (closed service, no
GitHub repo, issues disabled here), so this note is the ticket of record.
Until the API ships it, treat the uniform ladder as the contract *we* publish
and flag the divergence rather than encoding per-lab ladders in a provider
that has none of its own. See [[project-anyrouter-openai-compat]].
