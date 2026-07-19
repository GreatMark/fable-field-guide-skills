---
name: implementation-notes
description: >-
  Keep a running implementation-notes.md during implementation that logs
  decisions, plan deviations, and surprises, so the next iteration can learn
  from this one. Use PROACTIVELY whenever implementation of a reviewed plan
  or spec kicks off — e.g. the user says "implement the plan",
  "方案定了开始实现吧", "按计划实现", "plan's approved, start building" —
  even if notes are never mentioned. Also use when the user says "keep
  implementation notes", "记录实现笔记", "记一下偏离计划的地方". Not for
  post-hoc summaries of already-finished work.
---

# Implementation Notes

No plan survives contact with the codebase. Log what changed and why, without
stopping the work.

## Workflow

1. **At the start of implementation**, create `implementation-notes.md` in the
   project root. If the file already exists from a previous task, do not
   overwrite it — append a new `# Implementation Notes — <task name>
   (<YYYY-MM-DD>)` section at the end. Do not commit the file unless the user
   asks. If this is a git repo, exclude it locally:
   `grep -qxF implementation-notes.md "$(git rev-parse --git-path info/exclude)" || echo implementation-notes.md >> "$(git rev-parse --git-path info/exclude)"`
   (works in worktrees; if the environment blocks writing under `.git`, just
   leave the file untracked and never stage it). Structure:

```markdown
# Implementation Notes — <task name> (<YYYY-MM-DD>)
<!-- AGENT: keep logging decisions/deviations/surprises here as you work.
Before ending the session, re-read this file and give the user a digest of
Deviations and Open Questions. -->

## Context
Links to the plan/spec/prototype this run is based on (e.g.
implementation-plan.md, ./design-directions/). If the plan lives only in
chat, restate its one-line goal and key decisions here.

## Decisions
Choices made where the plan was silent. One line each: what + why.

## Deviations
Where reality forced a change from the plan.
Each entry: what the plan said / what was found / what was done instead / why.

## Surprises & Open Questions
Edge cases, dead code, wrong assumptions in the plan — anything the next
planning session should know.
```

2. **During implementation**, when an edge case forces a choice the plan
   didn't anticipate: pick the conservative option (smallest blast radius,
   easiest to reverse), log it under Deviations, and keep going. Only stop to
   ask the user when the deviation would invalidate the plan's goal.
3. **Update the file as you go**, not retroactively at the end. Entries are
   one to three lines; this is a log, not documentation. To survive long
   sessions: re-read `implementation-notes.md` before every commit and after
   completing each todo item — if you did something the plan didn't say and
   it's not in the file, log it before moving on. If you keep a todo list,
   make "update implementation-notes.md and give the digest" the final item.
4. **At the end of the session**, give the user a brief digest of Deviations
   and Open Questions — these are the discovered unknowns that should feed the
   next planning round. The digest is the immediate confirmation; the file is
   the cross-session handoff. Close by reminding the user to feed
   `implementation-notes.md` into the next planning round (or into
   pitch-explainer / change-quiz if this work heads to review).

## Rules

- Never silently deviate from the agreed plan; every deviation gets an entry.
- Cosmetic differences (naming, equivalent APIs) are not deviations unless
  they change behavior or interfaces.
- Do not duplicate what git already records (diffs, file lists); record the
  reasoning that a diff cannot show.
- When implementing in parallel worktrees, keep one notes file per worktree
  and merge the digests at integration time.
