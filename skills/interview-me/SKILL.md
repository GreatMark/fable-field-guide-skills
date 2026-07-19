---
name: interview-me
description: >-
  Interview the user one question at a time to turn ambiguities into explicit
  decisions before implementation, prioritizing questions whose answers would
  change the architecture. Use when the user says "interview me", "访谈我",
  "开工前把需求问清楚", "把不确定的点跟我逐个确认", "帮我理清需求",
  "ask me clarifying questions", or wants ambiguities resolved through Q&A
  before a task starts. Only for a structured pre-task interview started now.
  Not triggered when the user merely permits questions during implementation
  ("有不确定的可以问我", "ask me if unclear"), and not for researching
  codebase pitfalls (use blindspot-pass). Its decision record feeds
  implementation-plan.
---

# Interview Me

Resolve the user's known unknowns by interviewing them, one question at a
time, before any implementation.

## Workflow

1. **Build the question list silently.** From the conversation, plus a quick
   scan of relevant code (for greenfield work with no code yet, the
   conversation alone), list the ambiguities in the task. For each, note
   which layer the answer would change: architecture/data model >
   scope/behavior > UX details > cosmetics. Sort by that impact; when one
   answer gates other questions, ask the gating question first.
2. **Ask one question at a time.** Use the structured question tool when
   available (in Cursor, the AskQuestion option card). Every question must:
   - Present 2-4 concrete options, not an open-ended "what do you want?".
   - Put a recommended option first, marked "(recommended)" in its label.
   - Say why the answer matters (what it would change) and the trade-offs in
     the question body; keep option labels short.
   - Treat a free-text answer outside the listed options as a first-class
     answer.
3. **Re-plan after every answer.** The question list is a living document:
   drop questions the answer resolved, rewrite options it invalidated, add
   ambiguities it exposed. If the user changes a requirement mid-interview,
   say which earlier decisions it affects, update those, and rebuild the
   remaining list.
4. **Stop early.** End the interview once remaining unknowns would not change
   the approach — typically 3-7 questions. Never pad with questions you could
   answer yourself from the code; go read the code instead.
5. **Deliver the decision record.** Summarize in chat, in the language of the
   conversation, as a compact decision record ("known knowns") with three
   parts: decisions made; assumptions defaulted in place of an answer;
   deliberately deferred unknowns, each with the assumption chosen for it.
   Keep it ready to paste into an implementation prompt or plan. If planning
   or implementation will happen in a later session (or the user asks), also
   write it to `interview-decisions.md` in the project root. Do not commit it
   unless the user asks; in a git repo, exclude it locally:
   `grep -qxF interview-decisions.md "$(git rev-parse --git-path info/exclude)" || echo interview-decisions.md >> "$(git rev-parse --git-path info/exclude)"`
   (works in worktrees; if the environment blocks writing under `.git`, just
   leave the file untracked and never stage it). If planning comes next, hand
   this decision record to implementation-plan as its input.

## Rules

- One question per turn — a single structured-question call, then wait for
  the answer. Do not batch.
- If the user answers "I don't know", offer to prototype (the
  design-directions skill exists for this) or default to the recommended
  option and record it as an assumption — do not re-ask.
- The interview's deliverable is the decision record. Do not start
  implementing during the interview or right after it — wait for the user's
  go.
