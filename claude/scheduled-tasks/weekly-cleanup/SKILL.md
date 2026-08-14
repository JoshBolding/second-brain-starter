---
name: weekly-cleanup
description: Process new vault captures and promote sourced durable context
---

Process `<vault-path>\01 Inbox\`, `<vault-path>\01 Inbox\Agent Captures\`, and the last seven daily notes.

1. Classify each inbox note as project, area, resource, decision, lesson, procedure, archive candidate, or unresolved.
2. Move only notes whose source is inside `01 Inbox`; never move files already filed elsewhere.
3. Never delete notes.
4. Never edit `90 Archive\` or `99 Sensitive Review\`.
5. Update project current state only when a cited recent source supports it.
6. Preserve contradicted history and mark it superseded explicitly.
7. When filing a note, change `status: inbox` to the truthful destination state and set `updated`.
8. Add meaningful project/source links and verify every new target on disk.
9. Promote durable decisions and lessons without duplicating an existing entry.
10. Maintain `00 Home\Open Follow-ups.md`: add new follow-ups from the week's daily digests and this run's findings to the right section with a source wikilink and date; move an item to Resolved only when cited evidence shows it is done; carry everything else forward. Never silently drop an item.
11. Regenerate `00 Home\Vault Index.md` from the frontmatter of every project and area dashboard (status, `last_verified`, `next_action`). A full overwrite of the tables is expected for this generated file; update its `updated` date.
12. Staleness rule (projects only — areas are ongoing responsibilities and never demoted): any project dashboard with `status: active` and `last_verified` older than 21 days gets listed in the processing log as a proposed demotion to `waiting` or `paused`. Do not change a status without supporting evidence; repeat the proposal each run until the owner decides.
13. Cap each run at 25 created or edited notes, excluding the processing log, the manifest, `Vault Index.md`, and `Open Follow-ups.md`. Report remaining work instead of exceeding the cap.
14. Write a Markdown processing log in `00 Home` and a JSON manifest in `_system\sort-manifests\`.
15. Report stale active dashboards, broken links introduced by the run, and unresolved routing decisions.
16. Never copy credentials, tokens, connection strings, private keys, recovery codes, or secret values into summaries or manifests.
17. If there is nothing to process and the generated files need no changes, report that fact and make no writes.
18. Refresh the `## Current active context` section of `00 Home\AI Start Here.md` from this run's regenerated Vault Index: active projects and areas with their hub notes, plus where the most recent week's work is landing. Change only that section and the note's `updated` date.

Vault: `<vault-path>`
