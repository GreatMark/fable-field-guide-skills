---
name: design-directions
description: >-
  Generate several deliberately divergent single-file HTML prototypes with fake
  data so the user can react to designs before any real implementation.
  Use when the user wants design options, a UI mockup to react to, says
  "design directions", "出几个设计方向", "出几版 UI", "设计稿", "哪种布局好",
  "做几版界面让我挑", "我说不好想要什么样", or can only judge a design by
  seeing it. Not for technical feasibility spikes or functional MVPs
  ("做个原型验证跑不跑得通"), and not when the user points at one concrete
  reference to copy — that convergent case is reference-hunt; this skill is
  divergent exploration when no reference exists.
---

# Design Directions

The user has "unknown knowns": criteria they can only articulate when they see
something. Give them things to react to, cheaply, before touching real code.

## Workflow

1. Confirm scope from context: what surface is being designed (page, panel,
   component, report) and what data it shows. Do not ask more than one
   clarifying question; guessing reasonably is part of the point. If it
   turns out the user wants a technical feasibility spike
   ("做个原型验证方案行不行"), say this skill does not apply and build the
   spike instead — this skill is only for visual/UX exploration.
2. Build **4 deliberately different directions** by default (fewer only if the
   user asked). Different means different layout philosophy, density,
   hierarchy, or interaction model — not one design with four color schemes.
   Before building, state each direction's divergence axis in one line; if
   two axes repeat, rethink the weaker one.
3. Deliver as self-contained HTML: inline CSS/JS, realistic fake data
   hardcoded in (in the conversation's language), no build step, no network
   calls. Aim for high-fidelity visuals — the user should react to the
   design, not the sketchiness; static is fine, and add only the minimum JS
   that makes the core loop legible (e.g. a ticking timer for a timer app),
   nothing more. Include a viewport meta; default to desktop web unless the
   surface is obviously mobile — then wrap in a phone-width (390px) frame.
   Default to one file per direction (a single file with a direction
   switcher only if the user asks). Write files to a scratch directory under
   the project root (`./design-directions/`; in a non-project directory,
   confirm where to put them first), never into the real app; do not commit
   them, and if this is a git repo add the directory to `.git/info/exclude`.
4. Name each direction with a short memorable label and one sentence on the
   idea behind it, so the user can say "the second one, but denser".
5. Self-check before showing: render each file (headless browser or
   screenshot tool if available) and verify it holds up at the target
   viewport — no layout breakage, all fake data visible, no console errors.
   Fix before presenting; a broken first render defeats the purpose.
6. Present for reaction: screenshot each direction and embed the images in
   your reply (fall back to `open design-directions/*.html` if you cannot
   render), and ask what to keep and what to kill. Then iterate on the chosen
   direction, or combine elements on request.

## Rules

- Do not modify application code, add dependencies, or wire up backends at
  this stage.
- Use realistic fake data (plausible names, numbers, edge-case lengths) —
  lorem ipsum hides layout problems.
- If the project has an established design system, keep its tokens and
  branding; diverge on layout, density, and information architecture instead.
- Do not build these prototypes as Cursor canvases: canvas locks a single
  flat visual style and only works in the IDE, while divergent directions
  need free rein over visual language and a plain HTML file opens anywhere.
- Push at least one direction beyond the user's stated taste; the point is to
  discover what they didn't know they wanted.

## Examples

Four directions for a pomodoro timer — divergent because each is a different
layout philosophy, not one layout in four color schemes:

- **Monolith** — one giant timer, fullscreen, nothing else on screen.
- **Workbench** — three-pane workspace: task list, timer, session stats.
- **Garden** — playful narrative: each finished session grows a plant.
- **Ticker** — data-dense terminal: streaks, logs, and stats in a grid.
