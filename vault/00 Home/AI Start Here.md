---
type: ai-context
status: active
created: 2026-01-01
updated: 2026-01-01
ai_use: primary-entrypoint
sensitivity: normal
---

# AI Start Here

Purpose: this is the first note an AI assistant should read before helping with project history, prior decisions, idea reuse, or cross-project strategy.

This vault should help an AI understand its owner faster, remember what has already been tried, and transfer useful patterns between projects without turning the archive into a guilt machine.

## Read first

1. [[Vault Index]] — flat index of every project and area dashboard
2. [[Open Follow-ups]] — the single list of unresolved follow-ups
3. <!-- Add your own core context notes here, e.g. an operating profile, a decision log, a lessons-learned note -->

## How to use the vault

When asked about a project, idea, prior decision, or "what should we do with this," do this:

1. Find the relevant project or area dashboard via [[Vault Index]].
2. Read that dashboard, then its most recent linked notes and agent captures.
3. Check for prior attempts, lessons, and settled decisions before proposing something new.
4. Say which vault notes were used.
5. If a note looks stale, say so instead of treating it as current truth.

## What matters most

<!-- Describe, in a few bullets, what you value and what your main projects are about.
     This is the highest-leverage section: agents read it every session. -->

## Do not do

- Do not mass-organize old notes just because they exist.
- Do not copy secrets, tokens, API keys, passwords, recovery codes, or private customer details into summary notes.
- Do not suggest relitigating decisions before checking the decision history.

## Current active context

As of 2026-01-01 — refreshed weekly by the cleanup task from [[Vault Index]] evidence:

<!-- The weekly-cleanup task rewrites this section. Seed it by hand once. -->

## Freshness Rules

- Treat a project dashboard as current truth only when `last_verified` is recent and its source links support the claim.
- Read the newest linked daily or capture note when current state matters.
- Search `90 Archive/` only for history; never treat archive notes as current state without verification.
- Do not search or summarize `99 Sensitive Review/` unless explicitly asked.

## Live Structured Views

- [[Vault Index]] — AI-readable flat index of every project/area dashboard (status, freshness, next action); start here instead of scanning folders. Regenerated weekly.
- [[Open Follow-ups]] — the single list of unresolved follow-ups across all projects.
