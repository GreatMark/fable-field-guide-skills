---
name: change-quiz
description: >-
  Generate a self-contained HTML report explaining a change set, ending with a
  quiz the user must pass before merging. Use when the user says "quiz me" or
  "考考我" about a change set, says "change quiz", "变更测验", or after a
  large change or session wants to verify they truly understand what happened
  before approving or merging — e.g. "帮我确认下我真的理解了这些改动",
  "merge 之前帮我过一遍这轮改动". Only for understanding an existing diff,
  session, or PR. Not for writing tests, and not for general-knowledge or
  interview-style quizzes unrelated to a change set.
---

# Change Quiz

After a long session, the diff alone undersells what changed, because much of
the behavior depends on existing code paths. Build the user's understanding,
then verify it.

## Workflow

1. **Determine scope**: the current session's changes by default, or the
   diff/branch/PR the user points at. If there is no discernible change set,
   ask what to quiz on instead of guessing. Read the touched code *and* the
   existing code paths it plugs into. If `implementation-notes.md` exists,
   mine its Deviations and Surprises sections first — they are pre-indexed
   quiz material.
2. **Write one self-contained HTML file** (`change-report.html` in the
   project root, in the language of the conversation; inline CSS/JS, no
   network; overwrite any existing report — it describes the current change
   set only). It must stay out of the change set it describes: do not commit
   it, and if this is a git repo add the filename to `.git/info/exclude` (if
   that write is blocked, tell the user to add it manually and continue).
   Contents:
   - **Context & intent** — the problem, and the shape of the solution.
   - **What changed** — grouped by area, each linking file paths and
     explaining how the change interacts with pre-existing behavior.
   - **Behavior changes & risks** — what users/callers will observe
     differently; what could break and where to look if it does.
3. **End the file with a quiz**: 5-8 questions, answers hidden until clicked.
   Each question gets a "show answer" disclosure plus a self-check checkbox;
   a fixed score bar tracks N/total and turns green only at full marks.
   Target the parts most likely to surprise:
   - behavior that depends on existing code paths, not just new code
   - edge cases and failure modes the change handles (or deliberately doesn't)
   - "what happens if X" tracing questions
   Avoid trivia answerable by skimming the diff (file names, line counts).
4. **Hold the bar**: the rule is merge only after a perfect score.
   - Primary path: the user answers in chat *before* opening the hidden
     answers; grade strictly — for any miss, explain the right answer, point
     to the exact code, then ask one fresh question on the same topic.
     Passed = every question (including replacements) answered correctly.
   - Self-serve path: if the user self-checks against the hidden answers,
     take their word for it, but restate the rule.
   - For the rest of this session, if asked to merge before a pass, remind
     the user the quiz is unpassed before running the merge (advisory only —
     never refuse an explicit instruction).

## Rules

- Write questions from the reviewer's perspective ("will this break X?"), not
  the author's.
- For very large change sets (roughly >30 files or >2000 changed lines),
  group by subsystem, quiz only the 2-3 riskiest areas, and state in the
  report which areas the quiz does not cover.
- If the change is genuinely trivial, say a quiz is overkill and give a
  three-sentence summary instead.

## Examples

- Good question: "The new retry wrapper calls `fetchUser()` — what happens on
  the third failure, given the existing circuit breaker in `api/client.ts`?"
  Good because the answer lives in how the change interacts with a
  pre-existing code path, not in the diff itself.
- Bad question: "How many files did this change touch?" Bad because it is
  diff-skimming trivia that verifies reading, not understanding.
