# Fable 实战指南技能集(Fable Field Guide Skills)

八个用于**寻找你的 unknowns** 的 agent skill,源自 Claude Code 团队成员 [Thariq (@trq212)](https://x.com/trq212) 的文章 [《A Field Guide to Fable: Finding Your Unknowns》](https://x.com/trq212/status/2073100352921215386)——关于如何与 Claude Fable 5 协作。

同时支持 **Claude Code**(插件一键安装)和 **Cursor**(直接放入 `SKILL.md` 文件)。

[English](./README.md) | 简体中文

## 问题所在

来自 Thariq 的文章:

> "地图——对待办工作的表征——是我的 prompt、skill 和上下文,是我交给 Claude 的东西。疆域是工作真正发生的地方:代码库、真实世界、实际约束。[……]地图与疆域之间的差,就是我所说的 unknowns。"

> "Fable 是第一个这样的模型:我发现工作质量的瓶颈,在于我澄清它的 unknowns 的能力。"

> "重要的是,只靠提前规划并不总是够的。你可能在实现深处才发现 unknowns,或者你的 unknowns 会告诉你:其实应该换一种方式解决这个问题。"

模型越强,瓶颈越移向*你自己*:你没澄清的 unknowns,就是 agent 只能靠猜的决策。

## 认知框架

文章把一个问题拆成四个象限:

| | 你知道的 | 你不知道的 |
|---|---|---|
| **你意识到的** | **Known Knowns** —— 写在 prompt 里的东西 | **Known Unknowns** —— 还没想清楚、但你知道没想清楚的 |
| **你没意识到的** | **Unknown Knowns** —— 显而易见到你从不写下来、但一看就能认出来的 | **Unknown Unknowns** —— 你完全没考虑过的 |

> "在很大程度上,减少并规划你的 unknowns,就是 agentic coding 这门手艺本身。幸运的是,这是一项可以通过与 Claude 协作来提升的技能。"

## 解决方案

八个 skill,一一对应文章中的八个技巧,覆盖完整生命周期:

| 阶段 | Skill | 猎取的 unknowns |
|------|-------|----------------|
| 实现前 | [`blindspot-pass`](skills/blindspot-pass/SKILL.md) | Unknown Unknowns —— 你不知道该问的问题 |
| 实现前 | [`design-directions`](skills/design-directions/SKILL.md) | Unknown Knowns —— 只有看到才能说出的品味 |
| 实现前 | [`interview-me`](skills/interview-me/SKILL.md) | Known Unknowns —— 你知道还没解决的歧义 |
| 实现前 | [`reference-hunt`](skills/reference-hunt/SKILL.md) | Unknown Knowns —— 能指出来却描述不了的行为 |
| 实现前 | [`implementation-plan`](skills/implementation-plan/SKILL.md) | 最可能被改动的决策 |
| 实现中 | [`implementation-notes`](skills/implementation-notes/SKILL.md) | 半路发现的 unknowns |
| 实现后 | [`pitch-explainer`](skills/pitch-explainer/SKILL.md) | 评审者的 unknowns |
| 实现后 | [`change-quiz`](skills/change-quiz/SKILL.md) | 你对"刚刚改了什么"的 unknowns |

*四象限标签是我们的映射——文章并未给每个技巧指定象限。* 各 skill 的触发词与预期行为见 [EXAMPLES.md](./EXAMPLES.md)。

## 八个 Skill 详解

### 实现前

**`blindspot-pass`(盲区扫描)** —— 要在不熟悉的领域动工?先做一次盲区扫描。Claude 探索这片疆域,报告你不知道该问的问题、"好"长什么样、历史坑位,以及怎样把 prompt 写得更好。

> "我要加一个新的 auth provider,但我对这个代码库的 auth 模块一无所知。能不能做个 blindspot pass,帮我找出相关的 unknown unknowns,并帮我把 prompt 写得更好。"

**`design-directions`(设计方向)** —— 当你只有看到才认得出对的设计,让它生成 4 个刻意分化的单文件 HTML 原型(带真实感假数据)供你反应——在写任何真代码之前。(它打包的是文章"Brainstorms and prototypes"技巧中的原型那一半;范围头脑风暴那一半不需要 skill,直接问就行。)

> "我想给这些数据做个仪表盘,但我没有视觉品味,也不知道有哪些可能性。给我做一个包含 4 个截然不同设计方向的 HTML 页面,让我对着反应。"

**`interview-me`(访谈我)** —— 头脑风暴之后,你仍有*自己知道*的歧义。让它一次一题地访谈你,优先问答案会改变架构的问题,最后产出一份可直接粘贴的决策记录。

> "一次一个问题地访谈我,优先问我的回答会改变架构的问题。"

**`reference-hunt`(参考狩猎)** —— 有时你描述不出想要什么;最好的参考就是源代码。指向一个库、一个目录或网站上的一个模块——这个 skill 读真实实现,移植语义而非语法。

> "vendor/rate-limiter 里这个 Rust crate 实现了我想要的退避行为。读一下,把同样的语义在我们的 TypeScript API client 里重新实现。"

**`implementation-plan`(实现计划)** —— 按"被改动的可能性"而非时间顺序组织的计划:数据模型、类型接口、用户可见的决策放最上面;机械性重构埋在最底下。

> "用 HTML 写一份实现计划,但把我最可能调整的决策放在最前面:数据模型变更、新类型接口、以及一切用户可见的东西。机械性重构埋到最底下,那部分我信你。"

### 实现中

**`implementation-notes`(实现笔记)** —— 没有计划能在接触代码库后幸存。维护一份滚动更新的 `implementation-notes.md`,记录决策、偏离和意外——让下一轮规划从这一轮学到东西。

> "维护一份 implementation-notes.md。如果遇到迫使你偏离计划的边界情况,选保守方案,记在 'Deviations' 下,然后继续。"

### 实现后

**`pitch-explainer`(提案讲解)** —— 上线需要买入。把 spec、原型和实现笔记打包成一份自包含文档:demo 放最前,预先回答专家评审会追问的问题。

> "把原型、spec 和实现笔记打包成一份我能直接丢进 Slack 拉认同的文档。demo GIF 放最前面。"

**`change-quiz`(变更测验)** —— 长会话之后,diff 低估了实际发生的变化。生成一份带上下文和直觉的自包含 HTML 报告,结尾是一份你必须满分通过才能合并的测验。

> "我想确认自己理解了这次变更里发生的一切。给我一份 HTML 变更报告,让我带着上下文、直觉、做了什么等信息去读懂它,底部加一份关于这些变更的、我必须通过的测验。"

## 安装

**选项 A:Claude Code 插件(推荐)**

在 Claude Code 中添加插件市场:

```
/plugin marketplace add GreatMark/fable-field-guide-skills
```

然后安装插件:

```
/plugin install fable-field-guide-skills@fable-field-guide
```

八个 skill 即可在你所有项目中使用。

**选项 B:Cursor**

Cursor 从 `~/.cursor/skills/` 加载 `SKILL.md`:

```bash
git clone https://github.com/GreatMark/fable-field-guide-skills.git
cp -R fable-field-guide-skills/skills/* ~/.cursor/skills/
```

详见 [CURSOR.md](./CURSOR.md)。

**选项 C:Claude Code 个人 skills(不走插件)**

```bash
git clone https://github.com/GreatMark/fable-field-guide-skills.git
cp -R fable-field-guide-skills/skills/* ~/.claude/skills/
```

## Hooks(可选自动化)

安装 Claude Code 插件的同时会注册两个轻量 hook——超短、零依赖的 POSIX shell 脚本,fail-open,绝不阻塞会话(源码见 [`hooks/`](./hooks/)):

- **触发哨兵**(`UserPromptSubmit`,默认开启)—— 当你的消息包含高精度触发词("blindspot pass"、"盲区扫描"、"interview me"、"考考我"……)时,注入一行提醒,让对应 skill 确定性触发——即使你装了几十个其他 skill 也不会漏。未命中则零输出、零 token 开销。
- **合并守门**(`PreToolUse` on Bash,**默认关闭**)—— 开启后,检测到 `git merge` / `gh pr merge` 命令时注入一条建议性提醒:实战指南的规矩是通过 change-quiz 才合并。仅提醒,绝不拦截。按 shell 开启:`export FABLE_MERGE_GATE=1`;按项目开启:`mkdir -p .claude && touch .claude/fable-merge-gate`(标记文件按会话工作目录相对路径检查)。

想全部关掉:禁用插件即可(`claude plugin disable fable-field-guide-skills`)。Cursor 和纯 skills 安装方式(选项 B/C)不会注册任何 hook——那里 skill 只靠 description 触发。

## 核心洞察

来自 Thariq:

> "每一次讲解、头脑风暴、访谈、原型和参考,都是在'修复变得昂贵'之前,廉价地发现你所不知道的东西的方式。"

这些 skill 不是每次都要跑完的流水线,而是一个工具箱。文章的收尾建议:*下一个项目,从让 Claude 帮你找到你的 unknowns 开始。*

## 如何判断它在起作用

- **实现中途的意外更少** —— unknowns 在便宜的原型或访谈里被暴露,而不是在昂贵的重写里
- **你的 prompt 随时间越来越具体** —— 盲区扫描教会你该指定什么
- **计划在早期被否决,而不是晚期** —— 最可能改的决策最先被审
- **你能通过测验** —— 你真正理解了自己要合并的东西

## 这个仓库是怎么做出来的

与 [andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills)(把 Karpathy 关于 LLM 编码陷阱的观察蒸馏成可安装 skill)一脉相承:本仓库把 Thariq 的实战指南蒸馏成可安装的 skills。做法是把文章喂给编码 agent,让它把每个技巧转写成 `SKILL.md`,再由人工审阅迭代。技巧归文章,打包归我们,错误也归我们。

## 致谢与声明

- 方法论及全部引文:[Thariq (@trq212)](https://x.com/trq212),[《A Field Guide to Fable: Finding Your Unknowns》](https://x.com/trq212/status/2073100352921215386)(2026 年 7 月)。引用已注明出处;本页引文为中文翻译,英文原文见 [README.md](./README.md)。
- 这是社区项目,与 Anthropic 及原文作者无关联、未获其背书。Claude 与 Fable 是 Anthropic 的商标。

## 许可

MIT(覆盖本仓库中的 skill 文件与文档;引用的文章文字版权归原作者)。
