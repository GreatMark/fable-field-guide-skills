#!/bin/bash
# Fable Field Guide — merge gate v2 (Cursor beforeShellExecution hook)
#
# Advisory only: every code path allows the command; any error fails open.
# v2 changes vs v1:
#   1. Word-boundary ERE matching replaces substring globs: no more false
#      positives from "legit merge", "git mergetool", "git merge-file",
#      "git merge-tree", and no false negative when "git merge-base X Y"
#      precedes a real "git merge" in a compound command.
#   2. "git merge --abort/--quit" (abandoning a merge) no longer reminds.
#   3. Quiz-passed marker: if the report contains FIELD-GUIDE-QUIZ-PASSED
#      or a .change-quiz-passed sidecar file exists, stay silent. A newly
#      generated report has no marker, so the reminder re-arms itself.
#   4. stdin cap raised 64KiB -> 256KiB (less truncation on huge commands).

allow() { printf '{"permission":"allow"}\n'; exit 0; }

INPUT=$(head -c 262144 2>/dev/null) || allow
command -v jq >/dev/null 2>&1 || allow

CMD=$(printf '%s' "$INPUT" | jq -r '.command // empty' 2>/dev/null) || CMD=""
[ -n "$CMD" ] || allow

# Real merge commands only. ERE kept in variables for bash 3.2 `=~` compat.
# "merge" must be a standalone word: excludes merge-base/-file/-tree/mergetool.
# Leading boundary [^[:alnum:]_-] excludes "legit merge" / "digit merge-x".
# Optional "(-opt (value)?)*" run covers "git -C path merge", "git -c k=v merge".
RE_GIT_MERGE='(^|[^[:alnum:]_-])git[[:space:]]+(-[^[:space:]]+[[:space:]]+([^-][^[:space:]]*[[:space:]]+)?)*merge([[:space:]]|$)'
RE_GH_PR_MERGE='(^|[^[:alnum:]_-])gh[[:space:]]+pr[[:space:]]+merge($|[^[:alnum:]_-])'
RE_MERGE_ABANDON='merge[[:space:]]+--(abort|quit)([[:space:]]|$)'

if [[ "$CMD" =~ $RE_GIT_MERGE ]]; then
  # Abandoning a merge needs no quiz reminder.
  [[ "$CMD" =~ $RE_MERGE_ABANDON ]] && allow
elif [[ "$CMD" =~ $RE_GH_PR_MERGE ]]; then
  :
else
  allow
fi

# Locate the project root: prefer cwd/workspace roots from the hook input
# (user hooks run from ~/.cursor, so $PWD is not the project), then walk up
# to the git toplevel since change-report.html lives at the project root.
DIR=$(printf '%s' "$INPUT" | jq -r '.cwd // (.workspace_roots // [])[0] // (.workspaceRoots // [])[0] // empty' 2>/dev/null) || DIR=""
if [ -z "$DIR" ] || [ ! -d "$DIR" ]; then DIR="$PWD"; fi

ROOT=$(git -C "$DIR" rev-parse --show-toplevel 2>/dev/null) || ROOT="$DIR"
REPORT="$ROOT/change-report.html"
[ -f "$REPORT" ] || allow

# Quiz already passed -> no reminder. Marker lives inside the report (a fresh
# report resets it automatically); sidecar file kept as a manual fallback.
grep -q 'FIELD-GUIDE-QUIZ-PASSED' "$REPORT" 2>/dev/null && allow
[ -f "$ROOT/.change-quiz-passed" ] && allow

jq -cn '{
  permission: "allow",
  agent_message: "[FIELD GUIDE] Merge command detected and change-report.html exists in the project root, meaning a change-quiz was generated for this change set. The field-guide rule is: merge only after the user passes the quiz. If the quiz has not been passed, suggest completing it first. If the user has passed it, append an HTML comment FIELD-GUIDE-QUIZ-PASSED plus the date to change-report.html so this reminder stops. Advisory only — do not refuse if the user explicitly wants to merge."
}' 2>/dev/null || allow
exit 0
