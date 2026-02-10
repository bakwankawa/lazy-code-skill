#!/usr/bin/env bash
# Sync skills from obra/superpowers (main) into this repo's .codex/skills/superpowers/.
# Run from repo root. .codex/skills/lazy-code-skill/ is never touched.
# Skills-first behavior lives in .codex/rules/skill-first-engineering.mdc (not synced from upstream).
#
# Codex-adapted skills (not overwritten by sync; update by merging from upstream manually):
#   writing-skills, dispatching-parallel-agents, subagent-driven-development

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
UPSTREAM_URL="https://github.com/obra/superpowers.git"
UPSTREAM_BRANCH="main"
UPSTREAM_DIR="${REPO_ROOT}/.codex/.superpowers-upstream"
SUPERPOWERS_SKILLS_DIR="${REPO_ROOT}/.codex/skills/superpowers"

# Skills to copy from Superpowers (Codex-adapted ones are skipped; see SKIP_SYNC below)
SUPERPOWERS_SKILLS=(
  brainstorming
  dispatching-parallel-agents
  executing-plans
  finishing-a-development-branch
  receiving-code-review
  requesting-code-review
  subagent-driven-development
  systematic-debugging
  test-driven-development
  using-git-worktrees
  verification-before-completion
  writing-plans
  writing-skills
)

# Codex-adapted: do not overwrite; port upstream changes manually when needed
SKIP_SYNC=(writing-skills dispatching-parallel-agents subagent-driven-development)

cd "$REPO_ROOT"

echo "Cloning or pulling Superpowers (${UPSTREAM_BRANCH})..."
if [ -d "$UPSTREAM_DIR" ]; then
  git -C "$UPSTREAM_DIR" fetch origin "$UPSTREAM_BRANCH" && git -C "$UPSTREAM_DIR" checkout "$UPSTREAM_BRANCH" && git -C "$UPSTREAM_DIR" pull --ff-only
else
  git clone --depth 1 --branch "$UPSTREAM_BRANCH" "$UPSTREAM_URL" "$UPSTREAM_DIR"
fi

mkdir -p "$SUPERPOWERS_SKILLS_DIR"
UPSTREAM_SKILLS="${UPSTREAM_DIR}/skills"

is_skipped() {
  local name="$1"
  for s in "${SKIP_SYNC[@]}"; do
    if [ "$name" = "$s" ]; then return 0; fi
  done
  return 1
}

for name in "${SUPERPOWERS_SKILLS[@]}"; do
  if is_skipped "$name"; then
    echo "Skip (Codex-adapted, merge manually): ${name}"
    continue
  fi
  if [ -d "${UPSTREAM_SKILLS}/${name}" ]; then
    echo "Syncing skill: ${name}"
    rm -rf "${SUPERPOWERS_SKILLS_DIR:?}/${name}"
    cp -r "${UPSTREAM_SKILLS}/${name}" "${SUPERPOWERS_SKILLS_DIR}/"
  else
    echo "Skip (not found upstream): ${name}"
  fi
done

echo "Done. .codex/skills/lazy-code-skill/ is unchanged."
echo "Codex-adapted skills (not synced): ${SKIP_SYNC[*]}"
echo "Review changes with: git status ; git diff"
