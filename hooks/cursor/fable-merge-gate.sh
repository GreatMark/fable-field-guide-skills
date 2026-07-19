#!/bin/bash
# Fable Field Guide — merge gate (Cursor beforeShellExecution hook)
#
# Ported from GreatMark/fable-field-guide-skills hooks/merge-gate.sh.
# The field-guide rule: merge only after passing a change-quiz. When a merge
# command is seen and change-report.html (the change-quiz artifact) exists in
# the project root, inject an advisory reminder for the agent. It NEVER
# blocks: every code path allows the command, and any error fails open.

allow() { printf '{"permission":"allow"}\n'; exit 0; }

INPUT=$(head -c 65536 2>/dev/null) || allow
command -v jq >/dev/null 2>&1 || allow

CMD=$(printf '%s' "$INPUT" | jq -r '.command // empty' 2>/dev/null) || CMD=""
[ -n "$CMD" ] || allow

# Only real merge commands; git merge-base etc. pass through silently.
case "$CMD" in
  *"git merge-base"*) allow ;;
  *"git merge"* | *"gh pr merge"*) ;;
  *) allow ;;
esac

# Locate the project root: prefer cwd/workspace roots from the hook input
# (user hooks run from ~/.cursor, so $PWD is not the project), then walk up
# to the git toplevel since change-report.html lives at the project root.
DIR=$(printf '%s' "$INPUT" | jq -r '.cwd // (.workspace_roots // [])[0] // (.workspaceRoots // [])[0] // empty' 2>/dev/null) || DIR=""
if [ -z "$DIR" ] || [ ! -d "$DIR" ]; then DIR="$PWD"; fi

ROOT=$(git -C "$DIR" rev-parse --show-toplevel 2>/dev/null) || ROOT="$DIR"
[ -f "$ROOT/change-report.html" ] || allow

jq -cn '{
  permission: "allow",
  agent_message: "[FIELD GUIDE] Merge command detected and change-report.html exists in the project root, meaning a change-quiz was generated for this change set. The field-guide rule is: merge only after the user passes the quiz. If the quiz has not been passed, suggest completing it first. Advisory only — do not refuse if the user explicitly wants to merge."
}' 2>/dev/null || allow
exit 0
