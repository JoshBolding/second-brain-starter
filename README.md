# Second Brain Starter

An agent-maintained second brain built on **Obsidian** (plain Markdown, local-first) and **Claude Code** (or any agent that can read/write files on a schedule).

The idea: you work normally with your AI agents, and the vault maintains itself in three layers —

1. **Per-session capture (event-driven).** Agents follow a capture-by-default rule: any session that produces a durable lesson, decision, or reusable process writes a timestamped note into `01 Inbox/Agent Captures/`. Trivial Q&A gets skipped.
2. **Daily digest (scheduled, e.g. 5:00 AM).** A scheduled task reads all of yesterday's and today's agent session transcripts and rebuilds a digest section in each day's daily note — so even sessions that didn't self-capture get summarized. Follow-ups carry forward day to day until resolved.
3. **Weekly cleanup (scheduled, e.g. Monday 5:07 AM).** Sorts inbox captures into permanent homes, regenerates an AI-readable `Vault Index`, maintains a single cross-project `Open Follow-ups` list, and flags projects that have gone stale.

Agents get context the same way every time: read `AI Start Here` → check the `Vault Index` → read the relevant project dashboard → read the newest linked notes. Freshness is tracked with `last_verified` dates instead of assumed.

## Repo layout

```
vault/                          # Obsidian vault skeleton — point Obsidian at this
  00 Home/                      # Entry points: AI Start Here, Vault Index, Open Follow-ups, daily notes
  01 Inbox/Agent Captures/      # Where agents drop new captures
  02 Projects/                  # One folder + dashboard note per project
  03 Areas/                     # Ongoing responsibilities (never "done")
  04 Resources/                 # Reference material
  90 Archive/                   # History — never treated as current truth
  99 Sensitive Review/          # Quarantine for sensitive content — gitignored, agents never read it
  _templates/                   # Note templates (project, area, capture, daily, decision, resource)
  _system/sort-manifests/       # Machine-written logs from the weekly cleanup

claude/
  skills/second-brain/          # The always-available skill: retrieval order, capture rules, safety
  scheduled-tasks/daily-digest/     # Prompt for the daily digest job
  scheduled-tasks/weekly-cleanup/   # Prompt for the weekly cleanup job
```

## Setup

### 1. Create your vault

Copy the `vault/` folder wherever you keep your notes (or clone this repo and use it in place), then open that folder as a vault in Obsidian. Optionally `git init` inside it — the included `.gitignore` keeps `99 Sensitive Review/` and Obsidian workspace state out of history. **If you version your vault, keep that repo private.**

### 2. Install the skill

Copy `claude/skills/second-brain/` into `~/.claude/skills/`. Then open the three files and replace every `<vault-path>` placeholder with your vault's absolute path (e.g. `C:\Users\you\SecondBrain` or `/Users/you/SecondBrain`).

This skill is what makes agents capture by default and retrieve context in a consistent, safe order.

### 3. Schedule the two jobs

Copy both folders from `claude/scheduled-tasks/` into `~/.claude/scheduled-tasks/`, and replace `<vault-path>` in each `SKILL.md`. Then wire them to a schedule — either:

- **Claude Code scheduled tasks** (desktop app): ask Claude Code to "run the daily-digest task every day at 5:00 AM" and "run the weekly-cleanup task every Monday at 5:07 AM", or
- **Your own scheduler** (cron / Windows Task Scheduler): run headless, e.g.

  ```bash
  claude -p "$(cat ~/.claude/scheduled-tasks/daily-digest/SKILL.md)"
  ```

### 4. Seed the vault

Fill in `00 Home/AI Start Here.md` (it has placeholders), create a dashboard note in `02 Projects/` for each active project using `_templates/Project Note.md`, and let the automation take it from there.

## Conventions that make it work

- **Frontmatter contract** — every note uses the same small property set (`type`, `status`, `created`, `updated`, `last_verified`, `next_action`, `source`, …). See `claude/skills/second-brain/references/SCHEMA.md`. This is what lets the weekly job regenerate the Vault Index mechanically.
- **Current truth vs. history** — a dashboard is only "current" if `last_verified` is recent and its sources support it. Archive notes are history, never current state. Agents are told to say "this looks stale" instead of guessing.
- **Follow-ups never silently drop** — daily digests carry unchecked items forward with their origin date; the weekly job promotes them to `Open Follow-ups.md`; items only resolve with cited evidence.
- **Safety rails** — agents never read `99 Sensitive Review/`, never copy secrets into notes, never delete notes, and cap how many files a cleanup run may touch.

## Customizing

- Rename/renumber the folders freely — just keep the skill, the two scheduled tasks, and the templates consistent with each other.
- Using a second agent (Codex, a local model, etc.)? Give it the same skill and have it write its own `### <Agent> Digest` section under `## Agent activity` in the daily note — the schema is shared and each automation only ever replaces its own section.
- The 21-day staleness threshold, the 25-file cleanup cap, and the digest bullet caps are all just numbers in the prompts. Tune them.

## License

MIT — see [LICENSE](LICENSE).
