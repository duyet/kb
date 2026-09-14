---
name: tech-python-ast-docstring-markdown
title: Generate API markdown from Python docstrings with ast
description: Prefer stdlib ast over Sphinx/pdoc when emitting markdown API pages from docstrings without importing the app
type: tech
category: docs
tags: [python, docstrings, ast, documentation, markdown]
aliases: [python-docstring-reference, ast-api-docs]
related: ["[[feedback-docs-driven-development]]"]
created: 2026-09-14
updated: 2026-09-14
timestamp: 2026-09-14T00:00:00Z
---

For a large Python app that is expensive or env-heavy to import, generate **markdown API pages from docstrings with the stdlib `ast` module** (parse files, skip private/`_` names, skip undocumented publics). Do not import the package.

**Why:** Sphinx autodoc, pdoc, and mkdocstrings typically import the app. That needs secrets, settings, and optional deps. `ast` only needs source.

**How to apply:**

- Write one markdown file per module that has documented public classes or functions.
- Commit the generated tree next to the rest of the docs site so a static `/docs` viewer can serve it with no Python at build time.
- Keep HTTP OpenAPI as a separate generator. Do not mix route catalogs into the docstring tree.
- Scope the walk (package prefixes). A whole-`src` dump makes the sidebar unusable.
- Hand-editing generated pages is wrong; re-run the generator after docstring changes.

[[feedback-docs-driven-development]]
