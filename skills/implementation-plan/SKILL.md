---
name: implementation-plan
description: >-
  Write an implementation plan that leads with the decisions the user is most
  likely to change — data models, type interfaces, anything user-facing — and
  buries mechanical work at the bottom. Use when the user says "implementation
  plan", "实现计划", "实施计划", "开发计划", "落地方案", "写个实现方案",
  "先出方案再动手", or is ready to implement after brainstorming and wants a
  reviewable plan first. Also read this skill whenever entering Cursor's built-in Plan mode
  for a non-trivial task — it defines how that plan should be structured. Not
  for trivial changes, and not for resolving open questions with the user (run
  interview-me before planning).
---

# Implementation Plan

A plan's job is to surface the things the user might actually need to alter,
before changing them becomes expensive. Order it by likelihood of change, not
by execution order.

## Workflow

1. **Gather the inputs.** Collect what this plan is based on: the brainstorm,
   spec, interview decisions (from earlier in the conversation, or from
   `interview-decisions.md` in the project root if the interview ran in a
   previous session), any chosen prototype under `./design-directions/`, plus
   a read of the code that will be touched. If key inputs are missing and the
   unknowns would change the architecture, run interview-me first — or record
   explicit assumptions as decisions in the plan.
2. **Sort by likelihood of change, not chronology.** Lead with the decisions
   the user is most likely to tweak:
   - data model and schema changes
   - new type interfaces and API shapes
   - anything user-facing (UX flows, copy, layout)
   Bury the mechanical refactoring at the bottom — the user trusts the agent
   on that part.
3. **Make the top decisions reviewable.** For each high-change-risk decision:
   the chosen option, 1-2 alternatives considered, and what changing it later
   would cost. This is what lets the user veto cheaply.
4. **Mark the improvisation zones.** Flag the areas where unknowns are likely
   to surface mid-implementation, and state the fallback posture for each
   (e.g. "pick the conservative option and log it").
5. **End with an explicit go/no-go.** Present the plan in chat — decision
   list first — and ask the user to approve, adjust, or reject.
6. **On approval, persist and hand off.** Write the approved plan to
   `implementation-plan.md` in the project root, in the language of the
   conversation, using the skeleton below. Do not commit it unless the user
   asks. If this is a git repo, exclude it locally:
   `grep -qxF implementation-plan.md "$(git rev-parse --git-path info/exclude)" || echo implementation-plan.md >> "$(git rev-parse --git-path info/exclude)"`
   (works in worktrees; if the environment blocks writing under `.git`, just
   leave the file untracked and never stage it). Then, if Cursor's Plan mode
   is active, defer to its approve-and-execute flow; otherwise suggest
   starting implementation in a fresh session with `implementation-plan.md`
   (and any prototypes) passed in as artifacts. Either way, once
   implementation kicks off — especially in a new session — keep notes per
   the implementation-notes skill, with `implementation-plan.md` as the
   Context input of `implementation-notes.md`.

## Plan skeleton

```markdown
# Implementation Plan — <task>

## Decisions you may want to change   ← review this part
Each: the chosen option, 1-2 alternatives considered, cost to change later.
Most likely to change first.

## Improvisation zones
Likely mid-implementation unknowns, with the fallback posture for each.

## Mechanical work   ← no review needed
What will be done without further sign-off.

## Go / no-go
Approve, adjust, or reject — waiting on the user.
```

## Rules

- The plan is for review, not a contract — it should tell the reader where
  it is likely to be wrong.
- The three categories in step 2 are examples, not a checklist. The real
  sort key: how likely the user is to veto the decision, weighted by the
  cost of changing it later. For refactors with little user-facing surface,
  lead with behavior-preservation risks and public API touchpoints instead.
- If no decision rises above mechanical, say so in one line and offer to
  start immediately — a plan with nothing to veto is noise.
- Do not start implementing in the same breath as presenting the plan.
- If a plan section would just restate the obvious ("write the code, run the
  tests"), cut it; length is not thoroughness.
