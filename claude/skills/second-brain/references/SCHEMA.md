# Vault Property Contract

Use the same property type everywhere in the vault.

| Property | Type | Meaning |
|---|---|---|
| `type` | text | Note role: `project`, `area`, `resource`, `decision`, `capture`, `daily`, `ai-context`, or an established legacy role. |
| `status` | text | Truthful lifecycle state. Common values: `inbox`, `active`, `waiting`, `blocked`, `paused`, `reference`, `superseded`, `complete`, `archived`. |
| `created` | date or datetime | Original creation time; preserve it. |
| `updated` | date | Last meaningful content update. |
| `last_verified` | date | Last evidence-backed verification of current state. Do not refresh it for cosmetic edits. |
| `next_action` | text | Concrete next move or `Needs verification`; never invent one. |
| `projects` | YAML list of quoted wikilinks | Related canonical project dashboards. |
| `source` | scalar text | Origin label such as `human`, `Claude Code`, `import`, or `human-and-agents`. Never make this a list. |
| `source_notes` | YAML list of quoted wikilinks | Evidence notes supporting the content. |
| `sensitivity` | text | Normally `normal`; do not downgrade an existing sensitivity classification. |
| `supersedes` | YAML list | Prior decisions or notes explicitly replaced by this one. |

Example list syntax:

```yaml
projects:
  - "[[Example Project]]"
source: Claude Code
source_notes:
  - "[[2026-07-11 Example Evidence]]"
```

Current-state updates require recent evidence. Preserve historical content when a newer decision supersedes it.
