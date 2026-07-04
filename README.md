# Fable Field Guide Skills

Eight agent skills for **finding your unknowns**, derived from [Thariq (@trq212)](https://x.com/trq212)'s article ["A Field Guide to Fable: Finding Your Unknowns"](https://x.com/trq212/status/2073100352921215386) — written by a member of the Claude Code team about working with Claude Fable 5.

Works with **Claude Code** (installable plugin) and **Cursor** (drop-in `SKILL.md` files).

English | [简体中文](./README.zh.md)

## The Problem

From Thariq's article:

> "The map, a representation of the work to be done, is my prompts and skills and context, it's what I give Claude. The territory is where the work needs to happen, the codebase, the real world, its actual constraints. […] The difference between the map and the territory is what I call unknowns."

> "Fable is the first model where I find the quality of the work is bottlenecked by my ability to clarify its unknowns."

> "Importantly, just planning ahead isn't always enough. You can find unknowns deep in implementation, or your unknowns may point you to the fact that you should actually be solving the problem in a different way altogether."

The better the model, the more the bottleneck moves to *you*: the unknowns you didn't clarify are the decisions the agent has to guess.

## The Framework

The article breaks a problem down four ways:

| | You know it | You don't know it |
|---|---|---|
| **You know that you know/don't** | **Known Knowns** — what's in your prompt | **Known Unknowns** — what you haven't figured out yet, and know it |
| **You don't know that you know/don't** | **Unknown Knowns** — so obvious you'd never write it down, but you'd recognize it on sight | **Unknown Unknowns** — what you haven't considered at all |

> "In many ways, reducing and planning for your unknowns is the skill of agentic coding. But luckily, this is a skill you can improve at, by working with Claude."

## The Solution

Eight skills, one per technique in the article, covering the full lifecycle:

| Phase | Skill | Unknowns it hunts |
|-------|-------|-------------------|
| Pre-implementation | [`blindspot-pass`](skills/blindspot-pass/SKILL.md) | Unknown Unknowns — what you didn't know to ask |
| Pre-implementation | [`design-directions`](skills/design-directions/SKILL.md) | Unknown Knowns — taste you can only articulate on sight |
| Pre-implementation | [`interview-me`](skills/interview-me/SKILL.md) | Known Unknowns — ambiguities you know you haven't resolved |
| Pre-implementation | [`reference-hunt`](skills/reference-hunt/SKILL.md) | Unknown Knowns — behavior you can point at but not describe |
| Pre-implementation | [`implementation-plan`](skills/implementation-plan/SKILL.md) | The decisions most likely to change |
| During implementation | [`implementation-notes`](skills/implementation-notes/SKILL.md) | Unknowns discovered mid-flight |
| Post-implementation | [`pitch-explainer`](skills/pitch-explainer/SKILL.md) | Your reviewers' unknowns |
| Post-implementation | [`change-quiz`](skills/change-quiz/SKILL.md) | Your own unknowns about what just changed |

*The quadrant tags are our mapping — the article doesn't assign a quadrant to every technique.* For trigger phrases and expected behavior per skill, see [EXAMPLES.md](./EXAMPLES.md).

## The Eight Skills in Detail

### Pre-implementation

**`blindspot-pass`** — Starting work in an unfamiliar area? Ask for a blindspot pass. Claude explores the territory and reports the questions you didn't know to ask, what "good" looks like, historical potholes, and how to prompt better.

> "I'm working on adding a new auth provider but I know nothing about the auth modules in this codebase. Can you do a blindspot pass to help me figure out my relevant unknown unknowns and help me prompt you better."

**`design-directions`** — When you'd only recognize the right design on sight, get 4 deliberately divergent single-file HTML prototypes with realistic fake data to react to — before any real code. (This packages the prototyping half of the article's "Brainstorms and prototypes" technique; the scope-brainstorming half needs no skill — just ask.)

> "I want a dashboard for this data but I have no visual taste and don't know what's possible. Make me an HTML page with 4 wildly different design directions so I can react to them."

**`interview-me`** — After brainstorming you still have ambiguities you *know* about. Get interviewed one question at a time, prioritized by whether the answer would change the architecture, ending in a paste-ready decision record.

> "Interview me one question at a time about anything ambiguous, prioritize questions where my answer would change the architecture."

**`reference-hunt`** — Sometimes you can't describe what you want; the best reference is source code. Point at a library, folder, or website module — the skill reads the actual implementation and ports the semantics, not the syntax.

> "This Rust crate in vendor/rate-limiter implements the exact backoff behavior I want. Read it and reimplement the same semantics in our TypeScript API client."

**`implementation-plan`** — A plan ordered by likelihood-of-change, not chronology: data models, type interfaces, and user-facing decisions on top; mechanical refactoring buried at the bottom.

> "Write an implementation plan in HTML, but lead with the decisions I'm most likely to tweak with: data model changes, new type interfaces, and anything user-facing. Bury the mechanical refactoring at the bottom, I trust you on that part."

### During implementation

**`implementation-notes`** — No plan survives contact with the codebase. Keep a running `implementation-notes.md` logging decisions, deviations, and surprises — so the next planning round learns from this one.

> "Keep an implementation-notes.md file. If you hit an edge case that forces you to deviate from the plan, pick the conservative option, log it under 'Deviations', and keep going."

### Post-implementation

**`pitch-explainer`** — Shipping needs buy-in. Package the spec, prototype, and implementation notes into one self-contained doc that leads with the demo and pre-answers the questions expert reviewers would probe.

> "Package the prototype, the spec, and the implementation notes into a single doc I can drop in Slack to get buy-in. Lead with the demo GIF."

**`change-quiz`** — After a long session, the diff undersells what changed. Get a self-contained HTML report with context and intuition, ending in a quiz you must pass perfectly before merging.

> "I want to make sure I understand everything that's happened in this change. Give me a HTML report on the changes for me to read and understand with context, intuition, what was done, etc. and a quiz at the bottom on the changes that I must pass."

## Install

**Option A: Claude Code plugin (recommended)**

From within Claude Code, add the marketplace:

```
/plugin marketplace add GreatMark/fable-field-guide-skills
```

Then install the plugin:

```
/plugin install fable-field-guide-skills@fable-field-guide
```

All eight skills become available across your projects.

**Option B: Cursor**

Cursor loads `SKILL.md` files from `~/.cursor/skills/`:

```bash
git clone https://github.com/GreatMark/fable-field-guide-skills.git
cp -R fable-field-guide-skills/skills/* ~/.cursor/skills/
```

See [CURSOR.md](./CURSOR.md) for details.

**Option C: Claude Code personal skills (no plugin)**

```bash
git clone https://github.com/GreatMark/fable-field-guide-skills.git
cp -R fable-field-guide-skills/skills/* ~/.claude/skills/
```

## Key Insight

From Thariq:

> "Every explainer, brainstorm, interview, prototype, and reference is a cheap way to find out what you didn't know before it gets expensive to fix."

These skills are not a pipeline to run every time — they're a toolbox. The article's closing advice: *start your next project by asking Claude to help you find your unknowns.*

## How to Know It's Working

- **Fewer mid-implementation surprises** — unknowns get surfaced in a cheap prototype or interview instead of an expensive rewrite
- **Your prompts get more specific over time** — blindspot passes teach you what to specify
- **Plans get vetoed early, not late** — the decisions most likely to change are the first thing you review
- **You can pass the quiz** — you actually understand what you're merging

## How This Repo Was Made

In the same spirit as [andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) (which distilled Karpathy's observations on LLM coding pitfalls into an installable skill), this repo distills Thariq's field guide into installable skills. The skills themselves were drafted by pointing a coding agent at the article and asking it to turn each technique into a `SKILL.md` — then reviewed and iterated by a human. Techniques from the article, packaging by us, mistakes ours.

## Credits & Disclaimer

- Methodology and all quoted text: [Thariq (@trq212)](https://x.com/trq212), ["A Field Guide to Fable: Finding Your Unknowns"](https://x.com/trq212/status/2073100352921215386) (July 2026). Quoted under fair use with attribution.
- This is a community project, not affiliated with or endorsed by Anthropic or the article's author. Claude and Fable are trademarks of Anthropic.

## License

MIT (covers the skill files and docs in this repo; the quoted article text remains © its author).
