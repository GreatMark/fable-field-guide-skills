# Using with Codex and GPT-5.6 Sol

[简体中文](./CODEX.zh.md)

The eight skills are model-independent natural-language workflows. The Codex
plugin packages the same source files used by Claude Code and Cursor; it does
not maintain a separate Codex copy.

## Install

Add this repository as a Codex plugin marketplace, then install the plugin:

```bash
codex plugin marketplace add GreatMark/fable-field-guide-skills
codex plugin add fable-field-guide-skills@fable-field-guide-codex
```

Start a new Codex task after installation so the plugin and its skills are
loaded into fresh context.

## Select GPT-5.6 Sol

Plugins do not pin the active model. Select **Sol** in the Codex app or start
the CLI with:

```bash
codex -m gpt-5.6-sol
```

The skills use progressive disclosure: Codex initially sees their names and
descriptions, then loads only the matching `SKILL.md`. This keeps GPT-5.6
prompts lean instead of injecting all eight workflows into every task.

## Invoke a skill

Codex can match a skill from its description, or you can invoke it explicitly
with `$`:

```text
$blindspot-pass inspect the authentication area before I plan this change.
$interview-me resolve the architecture-changing ambiguities one at a time.
$change-quiz explain this branch and quiz me before I merge it.
```

## Hooks

The plugin includes two optional lifecycle hooks:

- `UserPromptSubmit` reinforces high-precision trigger phrases.
- `PreToolUse` provides an advisory merge reminder when the merge gate is on.

Codex requires review before running newly installed command hooks. Open
`/hooks`, inspect both definitions, and trust them if they match this repo.

The merge gate is off by default. Enable it for a shell session:

```bash
export FABLE_MERGE_GATE=1
```

Or enable it for one trusted project:

```bash
mkdir -p .codex
touch .codex/fable-merge-gate
```

The gate is advisory and never blocks an explicit merge request.

## Update or remove

Refresh the marketplace before reinstalling an updated version:

```bash
codex plugin marketplace upgrade fable-field-guide-codex
codex plugin add fable-field-guide-skills@fable-field-guide-codex
```

Remove the plugin with:

```bash
codex plugin remove fable-field-guide-skills@fable-field-guide-codex
```
