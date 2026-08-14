---
name: second-brain
description: Use when the user asks about prior context, current project state, decisions, plans, notes, cross-project connections, weekly review, vault maintenance, note routing, or capturing knowledge in their Obsidian second-brain vault.
---

# Second Brain

Use `<vault-path>` as the user's operating memory. Retrieve evidence before answering, distinguish current truth from history, and make only authorized, auditable writes.

## Safety boundary

- Start read-only.
- Never search, list, summarize, or expose `99 Sensitive Review` unless the user explicitly asks for that exact scope.
- Exclude `90 Archive`, `.obsidian`, `_assets`, and binary files from default search.
- Search `90 Archive` only when historical evidence is necessary; never use it as current truth by itself.
- Never copy credentials, tokens, private keys, recovery codes, connection strings, or secret values into notes, answers, logs, or manifests.
- Do not mass-edit, move, rename, delete, or reorganize notes without explicit authorization.

## Retrieval order

1. Read `00 Home/AI Start Here.md` when the task needs broad context or crosses projects.
2. Read `00 Home/Vault Index.md` to find the relevant project or area dashboard, then read that dashboard. An index row is a pointer, not evidence.
3. Check `last_verified`, `source_notes`, and the dashboard's Sources or recent-activity section.
4. Read the newest relevant linked daily notes and agent captures.
5. Search active project, area, and resource folders for missing context.
6. Search `90 Archive` only for history or when active sources explicitly point there.

Stop when enough evidence supports the answer. If active sources conflict, preserve both and report an unresolved contradiction.

## Search tools

- Run `scripts/Search-Vault.ps1` (Windows) or `scripts/search-vault.sh` (macOS/Linux) for filename or content search. Use `rg` directly only with the same exclusions.
- Read only the best matching notes, not every hit.

Examples:

```powershell
.\scripts\Search-Vault.ps1 -Query 'auth decision' -Mode Content -Vault '<vault-path>'
```

```bash
./scripts/search-vault.sh 'auth decision' content '<vault-path>'
```

## Current-truth contract

Classify important claims in your reasoning as one of:

- **verified current state**: supported by a recent `last_verified` boundary and linked evidence;
- **historical evidence**: true of a prior point in time but not confirmed current;
- **inference**: a conclusion drawn from sources, clearly labeled;
- **unresolved contradiction**: credible sources disagree or freshness is insufficient.

Do not turn a stale dashboard, old daily note, filename, index row, or Archive note into a current-state claim without corroboration.

## Answer contract

Lead with the practical answer. State uncertainty or staleness next to the affected claim. End research/context answers with a short `Vault Notes Used` list containing clickable full local paths for every note materially relied upon.

## Capture workflow

Capturing is the default, not a favor. Two triggers:

- **Explicit**: the user says save, capture, remember, log, or add this to the vault.
- **End-of-task**: any task that produced a durable lesson, multi-step solution, decision, or reusable process gets captured even if the user does not ask. Skip only pure Q&A, trivial edits, and work an existing note already covers.

For either trigger:

1. Search `01 Inbox/Agent Captures` and relevant active notes to deduplicate the idea.
2. If an existing capture covers it, update that note only when the user requested an update; otherwise report the match.
3. Create new captures in `01 Inbox/Agent Captures` with a timestamped filename: `YYYY-MM-DD-HHMM-short-title.md`.
4. Copy the live `_templates/Agent Capture.md`; do not maintain a duplicate template inside this skill.
5. Replace template variables and set `source` to the truthful runtime label (e.g. `Claude Code`).
6. Populate only supported content. Include why it matters, durable decisions or lessons, suggested home, and sources when evidence exists.
7. Verify every new wikilink resolves on disk before saving.

Use `references/SCHEMA.md` for property types and canonical semantics.

## Editing and routing

- Before editing an existing note, read it and state the exact path and purpose.
- Preserve frontmatter, wikilinks, tags, embeds, headings, and unrelated content.
- Make the smallest useful edit and re-read the changed section afterward.
- Suggest one to three homes when routing is ambiguous. Do not move the note without authorization.
- Update project current state only from cited recent evidence; preserve contradicted history and mark it superseded when appropriate.
- The canonical inbox is `01 Inbox`; agents write captures only to `01 Inbox/Agent Captures`.

## Common failure modes

- Broad recursive vault search: use the helper script or a scoped search.
- Treating the index as a source: open and verify the underlying note.
- Repeating an old decision as current: inspect freshness and evidence.
- Creating duplicate captures: search before writing.
- Guessing links or provenance: verify paths and use truthful `source` values.
