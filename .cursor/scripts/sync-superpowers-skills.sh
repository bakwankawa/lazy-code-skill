#!/usr/bin/env bash
# Sync skills from obra/superpowers (main) into this repo's .cursor/skills/superpowers/.
# Run from repo root. .cursor/skills/lazy-code-skill/ is never touched.
# Skills-first behavior lives in .cursor/rules/skill-first-engineering.mdc (not synced from upstream).

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
UPSTREAM_URL="https://github.com/obra/superpowers.git"
UPSTREAM_BRANCH="main"
UPSTREAM_DIR="${REPO_ROOT}/.cursor/.superpowers-upstream"
SUPERPOWERS_SKILLS_DIR="${REPO_ROOT}/.cursor/skills/superpowers"

# Skills to copy from Superpowers
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

cd "$REPO_ROOT"

echo "Cloning or pulling Superpowers (${UPSTREAM_BRANCH})..."
if [ -d "$UPSTREAM_DIR" ]; then
  git -C "$UPSTREAM_DIR" fetch origin "$UPSTREAM_BRANCH" && git -C "$UPSTREAM_DIR" checkout "$UPSTREAM_BRANCH" && git -C "$UPSTREAM_DIR" pull --ff-only
else
  git clone --depth 1 --branch "$UPSTREAM_BRANCH" "$UPSTREAM_URL" "$UPSTREAM_DIR"
fi

mkdir -p "$SUPERPOWERS_SKILLS_DIR"
UPSTREAM_SKILLS="${UPSTREAM_DIR}/skills"

for name in "${SUPERPOWERS_SKILLS[@]}"; do
  if [ -d "${UPSTREAM_SKILLS}/${name}" ]; then
    echo "Syncing skill: ${name}"
    rm -rf "${SUPERPOWERS_SKILLS_DIR:?}/${name}"
    cp -r "${UPSTREAM_SKILLS}/${name}" "${SUPERPOWERS_SKILLS_DIR}/"
  else
    echo "Skip (not found upstream): ${name}"
  fi
done

echo "Done. .cursor/skills/lazy-code-skill/ is unchanged."
echo "Review changes with: git status ; git diff"
