# AGENTS.md — Repo SSOT Contract (Fail-Closed)

## Mission

- Use OpenCode + OMOC to generate/maintain docs and code changes.
- All outputs must be reproducible in GitHub Codespaces.

## Non-negotiables (Fail-Closed)

- Do NOT bypass CI checks.
- Do NOT modify workflows or security settings unless explicitly instructed.
- Any generated docs must pass: mkdocs(strict) + markdownlint + vale + lychee.

## Definition of Done

- CI: all checks green.
- Links: no broken external links (except explicitly allowlisted).
- Style: Vale passes (no "error" level).
- Docs build: mkdocs --strict passes.

## Required Commands Before PR

- mkdocs build --strict
- markdownlint-cli2 "**/*.md"

OR use the convenience script:

- bash scripts/docs_gate_local.sh
