---
name: project-anyrouter-codexbar-declined
title: CodexBar declined the AnyRouter provider on endorsement grounds
description: steipete/CodexBar closed the AnyRouter provider PRs twice in favor of named-operator, upstream-authorization, and track-record gates
type: project
category: llm
tags: [project, anyrouter, llm, codexbar, endorsement, legal]
aliases: [codexbar-declined, codexbar-provider-decline]
related: ["[[project-anyrouter]]", "[[project-anyrouter-openai-compat]]", "[[project-anyrouter-cli-native]]", "[[project-anyrouter-catalog-one-id]]", "[[project-anyrouter-ui-chrome]]"]
sources: ["https://github.com/steipete/CodexBar/pull/2171", "https://github.com/steipete/CodexBar/pull/2218", "https://github.com/steipete/CodexBar/pull/4055", "https://anyrouter.dev/terms", "https://anyrouter.dev/brand", "https://github.com/duyet/anyrouter/issues/3650"]
created: 2026-09-27
updated: 2026-09-27
timestamp: 2026-09-27T00:00:00Z
---

`steipete/CodexBar` closed both AnyRouter provider PRs unmerged on 2026-07-17 — #2171 (duyetbot) and #2218 (joeVenner). The integration code was called clean; the block is **endorsement**: *"Shipping a provider in CodexBar is an implicit endorsement, so for aggregator/relay services I hold a higher bar than code quality."*

Three gates were named, and only the first is really blocking:

1. **Identifiable operator** — hard gate, still open. *"I can't point users at a service whose operator I can't identify."*
2. **Authorized upstream access** — wants a public statement of reseller/API agreements.
3. **Track record** — the service was very new.

**Why:** the code was never the problem. Reopening the PR before gate 1 closes earns a third decline on identical grounds.

**How to apply:** gate 1 needs a real legal person, not a copy edit — no entity is named in `src/app/terms.tsx` (`operator is established`, `AnyRouter and its operators`) and `src/app/contact.tsx` records the choice outright: *"the company does not publish one."* Never publish an entity name before it exists; an unnamed operator is an absence of information, a wrong entity is a false legal claim. Tracked in [duyet/anyrouter#3650](https://github.com/duyet/anyrouter/issues/3650).

Gates 2 and 3 are largely satisfiable from work already done: the 2026-08-26 Terms added a provider allowlist for donated keys, Polar is merchant of record, and inception was 2026-04-11. The public `/brand` page ships `anyrouter-logo-currentcolor.svg` (correct for a menu-bar app) and accent `#F38020` — the declined PR had a stale `#f6821f`.

Frame any re-proposal **BYOK-first**: the integration only reads *your own key's* credit balance over one read-only endpoint, so the shared pool is outside its surface.

**Status 2026-09-27:** re-proposed as steipete/CodexBar#4055, rebuilt on the current plugin architecture (see [[tech-codexbar-new-provider-is-a-plugin]]) — 25 lines of Swift plus a `.ts`, down from ~690 lines of bespoke Swift. Local gates green: 855 tests/113 suites, swiftformat, swiftlint, site locales, doc links, generated manifests. CI sits at `action_required` because a fork PR needs maintainer approval, so it has not run upstream yet. **The PR states plainly that gate 1 is still open and asks what form of disclosure would satisfy it** rather than papering over it.

Hub: [[project-anyrouter]].
