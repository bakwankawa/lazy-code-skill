#!/usr/bin/env bash
# Sync all skills from anthropics/skills (main) into this repo's .codex/skills/anthropic/.
# Run from repo root. Does not touch .codex/skills/lazy-code-skill/ or .codex/skills/superpowers/.

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
UPSTREAM_URL="https://github.com/anthropics/skills.git"
UPSTREAM_BRANCH="main"
UPSTREAM_DIR="${REPO_ROOT}/.codex/.anthropic-upstream"
ANTHROPIC_SKILLS_DIR="${REPO_ROOT}/.codex/skills/anthropic"
UPSTREAM_SKILLS="${UPSTREAM_DIR}/skills"

cd "$REPO_ROOT"

echo "Cloning or pulling anthropics/skills (${UPSTREAM_BRANCH})..."
if [ -d "$UPSTREAM_DIR" ]; then
  git -C "$UPSTREAM_DIR" fetch origin "$UPSTREAM_BRANCH" && git -C "$UPSTREAM_DIR" checkout "$UPSTREAM_BRANCH" && git -C "$UPSTREAM_DIR" pull --ff-only
else
  git clone --depth 1 --branch "$UPSTREAM_BRANCH" "$UPSTREAM_URL" "$UPSTREAM_DIR"
fi

mkdir -p "$ANTHROPIC_SKILLS_DIR"

for name in "${UPSTREAM_SKILLS}"/*/; do
  [ -d "$name" ] || continue
  name=$(basename "$name")
  echo "Syncing skill: ${name}"
  rm -rf "${ANTHROPIC_SKILLS_DIR:?}/${name}"
  cp -r "${UPSTREAM_SKILLS}/${name}" "${ANTHROPIC_SKILLS_DIR}/"
done

echo "Done. .codex/skills/anthropic/ updated from anthropics/skills."
echo "Review changes with: git status ; git diff"
