#!/usr/bin/env bash
# Sync skills from obra/superpowers (main) into this repo's .cursor/skills/.
# Run from repo root. Does not overwrite "own" skills (see OWN_SKILLS below).
# using-superpowers is kept as a RULE in .cursor/rules/ — not synced as a skill.

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
UPSTREAM_URL="https://github.com/obra/superpowers.git"
UPSTREAM_BRANCH="main"
UPSTREAM_DIR="${REPO_ROOT}/.cursor/.superpowers-upstream"
SKILLS_DIR="${REPO_ROOT}/.cursor/skills"

# Skills to copy from Superpowers (using-superpowers is a rule here, not a skill)
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

# Own skills: never overwrite these (we don't copy from upstream for these names)
OWN_SKILLS=(dual-remote-push efficient-code latency-logging new-project-scaffold pre-commit-docs-sync)

cd "$REPO_ROOT"

echo "Cloning or pulling Superpowers (${UPSTREAM_BRANCH})..."
if [ -d "$UPSTREAM_DIR" ]; then
  git -C "$UPSTREAM_DIR" fetch origin "$UPSTREAM_BRANCH" && git -C "$UPSTREAM_DIR" checkout "$UPSTREAM_BRANCH" && git -C "$UPSTREAM_DIR" pull --ff-only
else
  git clone --depth 1 --branch "$UPSTREAM_BRANCH" "$UPSTREAM_URL" "$UPSTREAM_DIR"
fi

mkdir -p "$SKILLS_DIR"
UPSTREAM_SKILLS="${UPSTREAM_DIR}/skills"

for name in "${SUPERPOWERS_SKILLS[@]}"; do
  if [ -d "${UPSTREAM_SKILLS}/${name}" ]; then
    echo "Syncing skill: ${name}"
    rm -rf "${SKILLS_DIR:?}/${name}"
    cp -r "${UPSTREAM_SKILLS}/${name}" "${SKILLS_DIR}/"
  else
    echo "Skip (not found upstream): ${name}"
  fi
done

echo "Done. using-superpowers is a rule in .cursor/rules/ — not overwritten."
echo "Review changes with: git status ; git diff"
