#!/bin/sh
# Fable Field Guide — trigger sentinel (UserPromptSubmit hook)
#
# Scans the user prompt for high-precision trigger phrases and injects a
# one-line reminder so the matching skill fires deterministically, even when
# many skills are installed. No match -> no output, zero token overhead.
# Fail-open: any error exits 0 and never blocks the session.

# Scan at most the first 64 KB: trigger phrases appear at the start of a
# prompt in practice, and this keeps worst-case latency far below the 3s
# hook timeout even for huge pasted prompts.
INPUT=$(head -c 65536 2>/dev/null) || exit 0
[ -n "$INPUT" ] || exit 0

# Echo-loop guard: skip if the prompt already contains our marker
# (e.g. the user pasted a previous reminder back in).
case "$INPUT" in *"[FIELD GUIDE]"*) exit 0 ;; esac

# Note: we deliberately match against the whole hook payload, not just the
# parsed "prompt" field — dependency-free, robust to payload schema changes;
# the rare false positive (a trigger phrase inside e.g. a cwd path) only
# costs one advisory line.
# ASCII-only lowercasing; UTF-8 multibyte sequences pass through untouched.
lower=$(printf '%s' "$INPUT" | LC_ALL=C tr 'A-Z' 'a-z') || exit 0

matches=""
check() {
  # $1 = trigger phrase (lowercase), $2 = skill name
  case "$lower" in
    *"$1"*)
      case " $matches " in
        *" $2 "*) ;;
        *) matches="$matches $2" ;;
      esac
      ;;
  esac
}

check "blindspot pass" "blindspot-pass"
check "盲区扫描" "blindspot-pass"
check "unknown unknowns" "blindspot-pass"
check "interview me" "interview-me"
check "访谈我" "interview-me"
check "问我问题" "interview-me"
check "design directions" "design-directions"
check "出几个设计方向" "design-directions"
check "做个原型看看" "design-directions"
check "reference hunt" "reference-hunt"
check "参考狩猎" "reference-hunt"
check "照着这个实现" "reference-hunt"
check "find me a reference" "reference-hunt"
check "implementation plan" "implementation-plan"
check "实现计划" "implementation-plan"
check "写个实现方案" "implementation-plan"
check "implementation notes" "implementation-notes"
check "实现笔记" "implementation-notes"
check "pitch doc" "pitch-explainer"
check "explainer" "pitch-explainer"
check "提案文档" "pitch-explainer"
check "打包给评审" "pitch-explainer"
check "change quiz" "change-quiz"
check "quiz me" "change-quiz"
check "考考我" "change-quiz"

[ -n "$matches" ] || exit 0
matches=${matches# }

# Invariant: the format string below must never contain user data — only
# $matches (a closed set of hardcoded skill names) is interpolated.
printf '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"[FIELD GUIDE] Trigger phrase detected. Before responding, invoke the matching skill(s) via the Skill tool: %s"}}\n' "$matches"
exit 0
