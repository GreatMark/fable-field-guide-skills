# 在 Codex 与 GPT-5.6 Sol 中使用

[English](./CODEX.md)

这八个 skill 是与模型无关的自然语言工作流。Codex 插件直接复用 Claude
Code 与 Cursor 使用的同一套源文件,不会维护一份单独的 Codex 副本。

## 安装

将本仓库添加为 Codex plugin marketplace,然后安装插件:

```bash
codex plugin marketplace add GreatMark/fable-field-guide-skills
codex plugin add fable-field-guide-skills@fable-field-guide-codex
```

安装后新建一个 Codex 任务,让插件和 skill 在干净的上下文中加载。

## 选择 GPT-5.6 Sol

插件不会锁定当前模型。请在 Codex App 中选择 **Sol**,或用以下命令启动
CLI:

```bash
codex -m gpt-5.6-sol
```

这些 skill 使用渐进式披露:Codex 开始时只看到名称与 description,只有匹配
任务后才加载对应的 `SKILL.md`。这样不会在每个任务中一次性注入八套工作流,
能保持 GPT-5.6 的 prompt 精简。

## 调用 skill

Codex 可以根据 description 自动匹配,也可以用 `$` 显式调用:

```text
$blindspot-pass 在规划前检查认证模块的盲区。
$interview-me 一次一个地澄清会改变架构的歧义。
$change-quiz 解释这个分支并在合并前考考我。
```

## Hooks

插件包含两个可选的生命周期 hook:

- `UserPromptSubmit` 强化高精度触发词。
- `PreToolUse` 在合并守门开启时提供建议性提醒。

Codex 会要求你在运行新安装的 command hook 前进行审核。打开 `/hooks`,
确认两个定义与本仓库一致后再信任。

合并守门默认关闭。可以对当前 shell 开启:

```bash
export FABLE_MERGE_GATE=1
```

也可以只对一个已信任项目开启:

```bash
mkdir -p .codex
touch .codex/fable-merge-gate
```

守门只提供建议,不会阻止用户明确要求的合并。

## 更新或移除

重新安装新版本前先刷新 marketplace:

```bash
codex plugin marketplace upgrade fable-field-guide-codex
codex plugin add fable-field-guide-skills@fable-field-guide-codex
```

移除插件:

```bash
codex plugin remove fable-field-guide-skills@fable-field-guide-codex
```
