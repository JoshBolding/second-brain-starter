---
name: daily-digest
description: Summarize daily agent activity into the vault's daily notes
---

Summarize recent Claude Code activity into the vault's daily notes: `<vault-path>\00 Home\Daily\YYYY-MM-DD.md`.

## Scope and sources

1. Use only file tools; do not run shell commands.
2. Find Claude Code session transcripts under `~\.claude\projects\` and ignore `subagents` transcript folders.
3. Cover a two-day window: yesterday and today, local time. A session belongs to the calendar date it started.
4. Rebuild the Claude Code Digest for each date in the window from all of that date's sessions, so work done after an early-morning run is picked up by the next morning's run. Yesterday's digest becomes final today; today's becomes final tomorrow.
5. If a daily note is missing, create it from `<vault-path>\_templates\Daily Note.md`, replacing template date variables first.
6. Never copy credentials, tokens, connection strings, private keys, recovery codes, or secret values.

## Digest schema (shared across agents)

7. All agent digests live under `## Agent activity` as sibling `###` sections: `### Claude Code Digest` (this automation) plus one section per additional agent, each maintained by its own automation. Replace only the Claude Code Digest section; never modify another agent's digest section. Preserve all other content and properties. If `## Agent activity` is missing in a legacy note, append it without rewriting the note.
8. Every digest starts with a one-sentence `**TL;DR:**` line, then exactly these four `####` subsections in order: `What happened`, `Decisions`, `Follow-ups`, `Projects touched`. An empty subsection contains the single bullet `- None.` — never omit a heading, and never write filler bullets like "no new activity verified".
9. `What happened`: at most 8 bullets, each a **bolded lead phrase** plus at most two plain sentences. Distill accomplishments and outcomes; omit tool-call minutiae; state interrupted or incomplete work honestly.
10. `Decisions`: one bullet per durable decision, one or two sentences each.
11. `Projects touched`: one line per project with real activity, using verified Obsidian wikilinks; merge those links into the note's `projects` property without removing existing values. List only projects with activity.

## Follow-up tracking

12. Write follow-ups as task checkboxes with an origin date: `- [ ] **(since YYYY-MM-DD)** description`. New items use the digest's date.
13. Carry-forward: when writing today's digest, read the follow-ups in yesterday's note (all digest sections). Unresolved unchecked items carry into today's Follow-ups with their original since-date. Items whose completion is evidenced in the sessions appear once more, checked: `- [x] **(since YYYY-MM-DD)** description — resolved YYYY-MM-DD: evidence`. Never silently drop a follow-up.
14. If open follow-ups exceed 12, keep the 12 most consequential and end the subsection with `- Plus N more in [[Open Follow-ups]]`.

## Overflow to project session notes

15. If one project dominates the day and its detail cannot fit rule 9's cap, create at most one session note in that project's folder — `02 Projects\<Project>\YYYY-MM-DD <Short Title>.md` — carrying the full detail, and link it from the digest. Frontmatter follows the capture convention: `tags: [agent-capture, ...]`, `created: YYYY-MM-DD`, `source: daily-digest`, `status: filed`. Open with a `**In one line:**` summary and a wikilink back to the project dashboard. Skip creation if a note for that date and topic already exists.

## Frontmatter signals

16. On each note in the window, set or update — preserving all other properties — `claude_sessions` (count of that date's Claude Code sessions) and `followups_open` (count of unchecked follow-up boxes across all digest sections after this run).

## Daily inbox rider

17. After writing digests, route at most 2 items from `01 Inbox\` or `01 Inbox\Agent Captures\` whose destination is unambiguous — an existing project or resource folder that clearly owns the content. Move only; never delete, and never touch `90 Archive\` or `99 Sensitive Review\`. Record each move in today's digest as an `**Inbox routing:**` line. When in doubt, leave the item for the weekly cleanup.
18. End today's digest with a single `**Inbox status:**` line — the count of unprocessed notes in `01 Inbox\` and `01 Inbox\Agent Captures\`.

## Integrity

19. Replacement must be idempotent: exactly one Claude Code Digest section per note, and reruns produce no duplicate bullets, duplicate frontmatter keys, or duplicate session notes.

Vault: `<vault-path>`
