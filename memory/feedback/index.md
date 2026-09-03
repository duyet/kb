# `feedback/`

## Concepts

- [Cheap models for sub-agents](feedback-cheap-models-subagents.md) — Fan-out sub-agents to cheaper models by default
- [Disambiguate which product/repo](feedback-disambiguate-repo.md) — When the user jumps between products, confirm target repo before large edits
- [Docs-Driven Development (index)](feedback-docs-driven-development.md) — Tiny router files + versioned kb brain; reflexive read/write
- [Fail loud; don't hide skips](feedback-fail-loud.md) — Never claim done if tests/steps were skipped silently
- [KB is the shared brain](feedback-docs-kb-is-brain.md) — Versioned, grep-able notes beat rules stuck only in prompts
- [KB stores public generic facts only](feedback-public-kb-only.md) — No secrets, hosts, internal project names, or adhoc session dumps
- [Keep main CI green, fast, and performant](feedback-main-ci-green-fast.md) — After merges and new features, verify main CI is green; do not add slow tests or extra hot-path queries
- [Keep router files tiny](feedback-docs-router-tiny.md) — CLAUDE.md/AGENTS.md = short stable rules + pointers, not architecture dumps
- [Logic change → update related tests](feedback-logic-change-update-tests.md) — Co-update tests in the same change; never wait for CI
- [Never auto-merge release-please PRs](feedback-never-auto-merge-release-please.md) — Leave release-please release PRs for human merge
- [Prefer simple code](feedback-simple-code.md) — Minimum code that solves the problem; no speculative abstraction
- [pstack verification is infra](feedback-pstack-verification.md) — Agents must close the loop themselves with a project-local verify skill, a CLI lever, a Feature Map, and cloud agents — not worktrees
- [Read MEMORY.md on entry](feedback-docs-read-on-entry.md) — Before non-trivial work, read the index and relevant notes
- [Semantic commits](feedback-semantic-commits.md) — Use conventional semantic commit messages
- [Surgical changes only](feedback-surgical-changes.md) — Touch only what the request requires; no drive-by refactors
- [Working style (index)](feedback-working-style.md) — Index of agent collaboration preferences
- [Write concise simple English](feedback-concise-english.md) — Prefer short plain English in prose and commits
- [Write memory as you work](feedback-docs-write-on-exit.md) — Persist durable public facts during work, not only at session end
