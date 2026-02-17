#!/usr/bin/env bash
# Sync all skills from vercel-labs/agent-skills (main) into this repo's .claude/skills/ (flattened).
# Run from repo root. Does not touch lazy-code-skill's own skills.

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
UPSTREAM_URL="https://github.com/vercel-labs/agent-skills.git"
UPSTREAM_BRANCH="main"
UPSTREAM_DIR="${REPO_ROOT}/.claude/.vercel-labs-upstream"
SKILLS_DIR="${REPO_ROOT}/.claude/skills"
UPSTREAM_SKILLS="${UPSTREAM_DIR}/skills"

cd "$REPO_ROOT"

echo "Cloning or pulling vercel-labs/agent-skills (${UPSTREAM_BRANCH})..."
if [ -d "$UPSTREAM_DIR" ]; then
  git -C "$UPSTREAM_DIR" fetch origin "$UPSTREAM_BRANCH" && git -C "$UPSTREAM_DIR" checkout "$UPSTREAM_BRANCH" && git -C "$UPSTREAM_DIR" pull --ff-only
else
  git clone --depth 1 --branch "$UPSTREAM_BRANCH" "$UPSTREAM_URL" "$UPSTREAM_DIR"
fi

mkdir -p "$SKILLS_DIR"

for name in "${UPSTREAM_SKILLS}"/*/; do
  [ -d "$name" ] || continue
  name=$(basename "$name")
  echo "Syncing skill: ${name}"
  rm -rf "${SKILLS_DIR:?}/${name}"
  cp -r "${UPSTREAM_SKILLS}/${name}" "${SKILLS_DIR}/"
done

echo "Done. .claude/skills/ updated with Vercel Labs skills (flattened)."
echo "Review changes with: git status ; git diff"
