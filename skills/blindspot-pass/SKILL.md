---
name: blindspot-pass
description: >-
  Surface the user's unknown unknowns before they start work in an unfamiliar
  area (new part of a codebase, new domain, new tool). Produces a read-only
  briefing of blindspots plus concrete advice on how to prompt better. Use when
  the user says "blindspot pass", "盲区扫描", "unknown unknowns", asks what
  they don't know or are likely to miss before diving in, or says things like
  "我刚接手这块代码", "开工前帮我看看有什么坑", "踩坑预警", "我会漏掉什么".
  Not for resolving known ambiguities by asking the user questions (use
  interview-me): this skill researches and briefs; it does not interview.
---

# Blindspot Pass

Help the user discover their unknown unknowns before work starts. This is a
read-only pass: do not modify any files.

## Workflow

1. **Anchor on the user's starting point.** If not already clear from the
   conversation, ask once — a single short message, at most three
   sub-questions — about their experience with this problem and codebase,
   what they have already decided, and what they plan to do next. If asking
   is not possible (or the user says "just go"), state your assumptions about
   their starting point in one line and proceed.
2. **Explore the territory.** Start from the files the task will touch and
   expand outward: direct dependencies/dependents, tests, docs, then git
   history of the touched files (not the whole repo). In large codebases,
   time-box this pass; depth beats coverage. If the domain is unfamiliar,
   search the web. Look specifically for things the user did not mention in
   their description of the task.
3. **Report blindspots** directly in the chat response, in the language of the
   conversation (do not create files unless the user asks for a document),
   organized as:
   - **Questions you didn't know to ask** — decisions hidden in this area
     (existing conventions, invariants, feature flags, edge cases).
   - **What "good" looks like** — quality bars, reference implementations, or
     prior art the user should calibrate against.
   - **History and potholes** — past attempts, known pitfalls, TODO/FIXME
     landmines, coupling that will bite.
   - **Domain concepts** — if the domain is new to the user, teach the 3-5
     concepts they need to evaluate results (not an encyclopedia).
4. **End with "how to prompt me better":** 3-6 concrete things the user should
   specify in their next prompt now that these blindspots are visible. If the
   remaining ambiguities are decisions only the user can make, suggest running
   interview-me next.

## Rules

- Prioritize blindspots that would change the user's approach; skip trivia.
- Cite checkable sources: file paths and line numbers for code; URLs or
  commit hashes otherwise.
- If the area turns out to be simple with few blindspots, say so plainly
  instead of inventing findings.
