---
name: field-guide
description: >-
  Master index for the fable field-guide family (8 finding-unknowns skills).
  Routes to the right skill — blindspot-pass, interview-me, design-directions,
  reference-hunt, implementation-plan, implementation-notes, change-quiz,
  pitch-explainer — and defines the artifact contract they all share. Use when
  the user says "field guide", "which skill",
  "该用哪个 skill", "这套流程怎么用",
  "finding unknowns 工具怎么选", asks which of these skills applies or how
  the family fits together; also read when unsure which finding-unknowns
  skill fits the current situation.
---

# Field Guide

Route by what kind of unknown is blocking the user right now, then read and
follow that skill. If two stages apply, prefer the earlier one.

## Routing table

| Stuck on | Skill |
| --- | --- |
| Unfamiliar area before starting; hidden pitfalls (unknown unknowns; 开工前不熟悉、怕有暗坑) | blindspot-pass |
| Known ambiguities the user must decide (known unknowns; 已知模糊点要用户拍板) | interview-me |
| Can't say what they want but would recognize it; no concrete reference (说不出想要什么、看到能认出) | design-directions |
| Has a concrete reference: "make it like that" (有具体参照物、要像它那样) | reference-hunt |
| Discussion converged, ready to build; reviewable plan first (讨论收敛要动手、先出可评审方案) | implementation-plan |
| Implementing an approved plan (按批准的方案实现中) | implementation-notes |
| Verify real understanding of this change set before merging (合并前验证自己真懂这轮改动) | change-quiz |
| Persuade reviewers who were out of the loop, after the work (说服不在环内的评审者) | pitch-explainer |

## Artifact contract (every skill in this family follows it)

- `implementation-plan.md`, `implementation-notes.md`, `change-report.html`,
  `pitch-<topic>.html` live in the project root; prototypes live in
  `./design-directions/`.
- Never commit artifacts: add them to `.git/info/exclude`; if that write
  fails, degrade to leaving them unstaged and tell the user.
- Artifact language follows the conversation language.
