---
name: reference-hunt
description: >-
  Port the semantics of a reference implementation (a library, folder, or
  website module) when the user cannot describe what they want in words.
  Reads the reference's actual source, not screenshots or docs. Use when the
  user says "reference hunt", "照着这个实现", "像这个一样", "参考这个库实现",
  "要做成像 X 那样/就是那个感觉" while pointing at a concrete product,
  library, or code, says "find me a reference", or struggles to articulate a
  behavior they can recognize. This skill converges on one concrete
  reference; if the user has none and needs divergent options to react to,
  use design-directions. Not for finding documentation or tutorials, and not
  for merely matching the project's existing code style.
---

# Reference Hunt

Sometimes the user cannot describe what they want in detail — they lack the
vocabulary, or describing it would take longer than showing it. The best
reference is source code.

## Workflow

1. **Get a pointer.** If the user already named a reference (a library, a
   vendored crate, a folder, a component on a website), start there. If not,
   propose 2-3 candidate references yourself — from the codebase, vendored
   dependencies, or well-known open-source implementations — and let the user
   pick. One short message, not an interview.
2. **Read the real implementation.** Locate the source in this order:
   `node_modules`/vendored copies inside the project → the package's
   repository at the installed version (`npm view <pkg> repository` or the
   ecosystem's equivalent, then fetch the tagged file) → GitHub code search.
   For a website module, read the underlying markup and code. Read the
   source, not its README, docs, or a screenshot. **Also skim its test
   file** — edge-case semantics (ordering, error paths, boundary values)
   live in tests more reliably than in the implementation body. A different
   language than the target is fine; semantics transfer, syntax does not.
3. **Write down what you are taking.** Before implementing, give the user a
   short list, in the language of the conversation: the semantics being
   ported and what is deliberately *not* being ported. Cover five dimensions:
   inputs/API shape, outputs and return values, state transitions, edge
   cases, failure behavior. This is where the user's "I'd know it when I see
   it" gets checked cheaply. The list must outlive the chat: if
   implementation starts now, record it under Context/Decisions in
   `implementation-notes.md` (per the implementation-notes skill); otherwise
   write it to `porting-checklist.md` in the project root — do not commit it
   unless the user asks; in a git repo, exclude it locally:
   `grep -qxF porting-checklist.md "$(git rev-parse --git-path info/exclude)" || echo porting-checklist.md >> "$(git rev-parse --git-path info/exclude)"`
   (works in worktrees; if the environment blocks writing under `.git`, just
   leave the file untracked and never stage it).
4. **Reimplement, don't transplant.** Port the behavior into the target
   stack following the project's existing conventions and idioms. Cite the
   reference file paths — with version or commit for remote references
   (e.g. `lodash@4.17.21 debounce.js`) — in your summary so claims are
   checkable.

## When source is not readable

- Website with minified JS: check for sourcemaps first; otherwise use the
  minified code only to confirm structure, and find an open-source
  implementation of the same pattern to read for semantics.
- Closed-source SaaS or nothing readable: tell the user you are downgrading
  to black-box observation (drive the UI/API, record behavior as a table of
  input → output/state), and mark ported semantics as "observed, not read".
- Reference too large to read fully: read only the module that owns the
  behavior the user pointed at, plus its tests; name what you skipped.

## Rules

- Never copy code verbatim from an external reference — port semantics and
  match the project's style. Check the reference's license first: permissive
  (MIT/Apache/BSD) is fine to port from with attribution in your summary;
  for GPL-family or no license, warn the user before proceeding.
- If the reference's behavior conflicts with something the user stated,
  surface the conflict instead of silently picking one.
- If the reference turns out to be a poor fit, say so and propose another —
  a bad reference is worse than none.
