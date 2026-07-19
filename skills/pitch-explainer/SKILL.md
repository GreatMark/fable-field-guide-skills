---
name: pitch-explainer
description: >-
  Package the spec, prototype, and implementation notes of a finished piece of
  work into one self-contained document that gets reviewers to buy-in fast.
  Use when the user says "pitch doc", "提案文档", "打包给评审", "写个提案",
  "汇报材料", "评审材料", asks for a one-pager, write-up, or explainer aimed
  at reviewers or approvers, or needs sign-off from people who weren't in the
  loop. Only for persuading stakeholders about finished or nearly-finished
  work. Not for neutral knowledge docs — wikis, READMEs, onboarding guides,
  or explaining a module with no approval audience.
---

# Pitch & Explainer

Shipping needs buy-in. Reviewers start with the same unknowns the author
started with; experts want to see that the failure points they'd probe were
accounted for. Build the document that closes both gaps.

## Workflow

1. **Collect the artifacts.** Look for `implementation-notes.md` (project
   root) and the chosen prototype under `design-directions/` — sibling skills
   leave them there. Also gather: the plan or spec, the diff, demo media
   (GIF/screenshots). If notes are missing, mine the session history and
   `git log -p` for decisions and surprises instead. Ask once if a key
   artifact is missing, then work with what exists. If a prototype was chosen
   from multiple directions, say so in the doc — "reviewed 4 directions, ops
   picked this one" is itself evidence of diligence.
2. **Lead with the demo.** The first thing a reviewer sees should be the
   thing working — a demo GIF, screenshot, or live link. If no demo media
   exists (the common case for agent sessions): embed the work's actual
   output — a rendered report, a before/after diff of real behavior, a
   terminal transcript of the thing running. For pure backend work with
   nothing visual, lead with the single most convincing evidence of "it
   works": a passing test run, a latency number, a real request/response
   pair. Never skip this slot; never fake media that doesn't exist. A
   static recreation or mockup is fine only when labeled as such — never
   present it as a screenshot of the shipped thing; one discovered fake
   kills the document's credibility. Embed images as base64 data URIs so
   the file survives being dragged into Slack without breaking links.
   Architecture comes after belief.
3. **Write one self-contained document** (`pitch-<topic>.html` in the project
   root, in the reviewer's language — default to the conversation's; inline
   CSS/no network; markdown if the venue demands it). Do not commit it unless
   asked; in a git repo add it to `.git/info/exclude`, matching
   design-directions and implementation-notes conventions. Structure:
   - **The demo** — show it working, first.
   - **The problem** — why this exists, in the reviewer's terms.
   - **What it changes** — the before/after in numbers the reviewer cares
     about (time saved, errors prevented, money unblocked). One or two,
     honest.
   - **What was built** — the shape of the solution, key decisions and why.
   - **Anticipated questions** — the failure points and edge cases an expert
     reviewer would probe, each answered honestly. Pull from the
     implementation notes' Deviations and Surprises if they exist.
   - **Limitations & open questions** — what this deliberately does not do.
   - **The ask** — end with the exact decision requested: approve to ship,
     approve the rules, or a specific next step with a date.
4. **Make it droppable.** One file the user can drop into Slack or an issue:
   no build step, no external dependencies, readable on a phone. The
   deliverable is the file itself — do not render it as a canvas.

## Rules

- Write for the reviewer's unknowns, not the author's pride — the goal is
  that their first question is already answered in the doc.
- Do not oversell: limitations stated up front build more trust than
  completeness claimed and disproven.
- Every number and claim must trace to the spec's acceptance criteria or the
  implementation notes' measurements — never invent metrics to make the win
  look bigger.
- If the approach is contestable, add an "Alternatives considered" line to
  What was built: name the strongest rival option and the honest reason it
  lost. One line per alternative, no straw men.
- Keep it readable in five minutes — roughly 800 words (or ~1500 Chinese
  characters); count after writing and cut. Link out for depth only via URLs
  the reviewer can actually reach (issue, repo, doc link) — never relative
  file paths; if no reachable link exists, inline a short appendix instead.
