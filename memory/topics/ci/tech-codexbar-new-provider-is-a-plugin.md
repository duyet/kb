---
name: tech-codexbar-new-provider-is-a-plugin
title: A new CodexBar provider is a declarative spec plus one TypeScript plugin
description: CodexBar moved simple API-key providers to bundled QuickJS plugins; a new provider is ~25 lines of Swift plus a .ts file, not bespoke Swift
type: tech
category: ci
tags: [tech, codexbar, swift, plugin, quickjs, provider, contribution]
aliases: [codexbar-provider-plugin, codexbar-plugin-provider]
related: ["[[project-anyrouter-codexbar-declined]]", "[[project-anyrouter]]", "[[tech-note-atomic]]"]
sources: ["https://github.com/steipete/CodexBar/tree/main/Sources/CodexBarCore/Plugins", "https://github.com/steipete/CodexBar/blob/main/Scripts/regenerate-provider-manifests.sh", "https://github.com/steipete/CodexBar/blob/main/Scripts/regenerate-plugin-js.sh"]
created: 2026-09-27
updated: 2026-09-27
timestamp: 2026-09-27T00:00:00Z
---

A **new** CodexBar provider is a declarative `PluginProviderSpec` plus one bundled TypeScript plugin. It is not bespoke Swift. Simple API-key providers were migrated during the 0.68 cycle (`refactor(plugins): add declarative API-key provider builders`, `migrate simple API-key providers`).

The whole provider is: `case <id>` in `UsageProvider`; a `<Name>ProviderDescriptor.swift` declaring `id: .<id>,` with `public static let spec = PluginProviderSpec(` **and** `apiKeyField: .init(`; `<id>.ts` + its transpiled `<id>.js`; the icon SVG. That is roughly 25 lines of Swift.

**Why:** `Scripts/regenerate-provider-manifests.sh` reads the enum order plus the descriptor's shape and generates the descriptor manifest, the implementation manifest, `ProviderInstanceIDAliases.generated.swift`, and `docs/provider-ids.md`. Having both `spec` and `apiKeyField` makes the script emit `PluginAPIKeyProviderImplementation(spec: X.spec)`, so **no `ProviderImplementation` file is needed at all**.

**How to apply:**
- Run `Scripts/regenerate-plugin-js.sh` and `Scripts/regenerate-provider-manifests.sh`; both have a `check` mode that CI enforces.
- In a plugin `.ts`, `catch (error) { void error; ... }` — sucrase rewrites the optional catch binding and oxlint's `no-unused-vars` then fails on the result. Annotate parameters; the `.ts` is type-checked.
- `ctx.format.usd()` is native en_US currency formatting, so money rows are exact — write literal expectations in tests.
- Adding a provider also needs: `BurnProviderChoice` (asserted exhaustive), the `balanceOnly`/fingerprint constants in `ProviderArchitectureGatekeeperTests`, the advertised provider count (87 -> 88) across 7 files including 23 site locales, a `docs/index.html` provider card, and a re-rendered `docs/social.png`.
- The `plugin-provider-specs.json` golden covers a **curated** 31-provider list, not every provider, so a new provider need not be added.
- CI runs `ubuntu-24.04` with **Swift 6.3.3**; `CodexBarPluginTests` (`TestsPlugin`) and `CodexBarLinuxTests` run there, but `Tests/CodexBarTests` is macOS-only.

Gatekeeper fingerprints can be recomputed off-macOS: `ProviderDescriptorRegistry` lives in `CodexBarCore`, so a throwaway test in `TestsPlugin` can run the test's own hash over the registry and print the new constants. Verified: the untouched `debugLogUnavailableMessage` fingerprint reproduced its committed value exactly.

Decline history: [[project-anyrouter-codexbar-declined]].
