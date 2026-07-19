# Examples

Trigger phrases and what to expect from each skill. All example prompts in
quotes are adapted from [the original article](https://x.com/trq212/status/2073100352921215386).

## field-guide

**Triggers:** "field guide", "该用哪个 skill", "这套流程怎么用", "where do I even start"

```
I have all these finding-unknowns skills installed but I'm not sure which
one fits where I'm stuck right now. Which should I use?
```

**Expect:** the router of the family — it maps "what kind of unknown is
blocking you" to one of the eight workflow skills (or tells you no skill is
needed), and defines the artifact contract they share:
`interview-decisions.md`, `porting-checklist.md`, `implementation-plan.md`,
`implementation-notes.md`, `change-report.html`, `pitch-<topic>.html` in the
project root, prototypes under `./design-directions/`.

## blindspot-pass

**Triggers:** "blindspot pass", "盲区扫描", "unknown unknowns", "我刚接手这块代码", "what don't I know before diving in"

```
I'm working on adding a new auth provider but I know nothing about the auth
modules in this codebase. Can you do a blindspot pass to help me figure out
my relevant unknown unknowns and help me prompt you better.
```

**Expect:** a read-only briefing — questions you didn't know to ask, what
"good" looks like here, history and potholes, key domain concepts — ending
with 3-6 concrete things to specify in your next prompt.

## design-directions

**Triggers:** "design directions", "出几个设计方向", "出几版 UI", "哪种页面风格好", "make me something to react to"

```
I want a dashboard for this data but I have no visual taste and don't know
what's possible. Make me 4 wildly different design directions so I can react
to them.
```

**Expect:** 4 deliberately divergent single-file HTML prototypes with
realistic fake data in `./design-directions/`, each with a memorable name —
so you can say "the second one, but denser".

## interview-me

**Triggers:** "interview me", "访谈我", "开工前把需求问清楚"

```
Interview me one question at a time about anything ambiguous, prioritize
questions where my answer would change the architecture.
```

**Expect:** one multiple-choice question per turn, recommended option first,
each with why-it-matters; ends with a paste-ready decision record — also
written to `interview-decisions.md` when planning happens in a later session.

## reference-hunt

**Triggers:** "reference hunt", "照着这个实现", "find me a reference"

```
This Rust crate in vendor/rate-limiter implements the exact backoff behavior
I want. Read it and reimplement the same semantics in our TypeScript API
client.
```

**Expect:** it reads the reference's actual source, lists the semantics it
will port (and won't) as a taking list, confirms with you, then reimplements
in your stack's idioms — never a verbatim copy. If implementation happens
later, the list is persisted as `porting-checklist.md`.

## implementation-plan

**Triggers:** "implementation plan", "实现计划", "落地方案", "写个实现方案"

```
Write an implementation plan, but lead with the decisions I'm most likely to
tweak: data model changes, new type interfaces, and anything user-facing.
Bury the mechanical refactoring at the bottom, I trust you on that part.
```

**Expect:** a plan sorted by likelihood-of-change with alternatives and
change-costs for the top decisions, flagged improvisation zones, and an
explicit go/no-go at the end; on approval the plan is persisted to
`implementation-plan.md` in the project root (kept out of git via
`info/exclude`) as the handoff artifact for implementation-notes. When a
built-in plan mode is active (Cursor, Claude Code, Codex), the host's native
plan file is the only artifact instead.

## implementation-notes

**Triggers:** "keep implementation notes", "记录实现笔记", or kicking off implementation of a reviewed plan

```
Keep an implementation-notes.md file. If you hit an edge case that forces
you to deviate from the plan, pick the conservative option, log it under
'Deviations', and keep going.
```

**Expect:** a running log of decisions / deviations / surprises that stays
out of your diff, plus an end-of-session digest of what the next planning
round should know.

## pitch-explainer

**Triggers:** "pitch doc", "explainer", "提案文档", "打包给评审", "把成果打包成汇报材料"

```
Package the prototype, the spec, and the implementation notes into a single
doc I can drop in Slack to get buy-in. Lead with the demo GIF.
```

**Expect:** one self-contained `pitch-<topic>.html` (images embedded as
base64 so it survives being dragged into Slack) that leads with the demo,
explains the problem and decisions, pre-answers the questions expert
reviewers would probe, states limitations honestly, and ends with "The ask" —
the exact decision requested.

## change-quiz

**Triggers:** "quiz me", "考考我", "change quiz", "变更测验"

```
I want to make sure I understand everything that's happened in this change.
Give me an HTML report on the changes for me to read and understand with
context, intuition, what was done, etc. and a quiz at the bottom on the
changes that I must pass.
```

**Expect:** a self-contained `change-report.html` explaining the change in
context, ending with a 5-8 question quiz (answers hidden until clicked). The
rule: merge only after a perfect score.
