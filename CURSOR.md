# Using with Cursor

These skills were originally drafted and battle-tested in Cursor, which loads
`SKILL.md` files from `~/.cursor/skills/` (one directory per skill).

## Install

```bash
git clone https://github.com/GreatMark/fable-field-guide-skills.git
cp -R fable-field-guide-skills/skills/* ~/.cursor/skills/
```

Restart Cursor (or start a new agent session) and the skills are picked up.
Each skill's `description` frontmatter contains its trigger phrases — both
English ("blindspot pass", "interview me", "quiz me") and Chinese
("盲区扫描", "访谈我", "考考我").

## Enable / disable individual skills

Cursor treats each directory under `~/.cursor/skills/` as one skill. To
disable one, move its directory out (e.g. to `~/.cursor/skills-archived/`).
There is no per-skill toggle in the UI as of Cursor 3.x.

## Relationship to Claude Code and Codex

The same `SKILL.md` format works in Cursor, Claude Code, and Codex. In Claude
Code or Codex you can install this repo as a plugin instead (see
[README](./README.md#install)), which keeps the skills updatable via a
marketplace; in Cursor the copy above is the whole story.

One behavioral difference worth knowing: Claude Code surfaces skills through
its `Skill` tool and shows the invocation in the transcript; Cursor matches
on the description text and folds the skill into context silently. If a
skill doesn't seem to fire in Cursor, use its trigger phrase verbatim.
Codex loads matching skills progressively and supports explicit `$skill-name`
invocation; see [CODEX.md](./CODEX.md).

Note: the optional automation hooks in [`hooks/`](./hooks/) (trigger
sentinel, merge gate) are Claude Code and Codex plugin features and do not
apply to Cursor — copying the skills directory brings the skills only.
