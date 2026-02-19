#!/usr/bin/env bash
# Install lazy-code-skill for Claude (project-level).
# Run from the ROOT of the project where you want skills and rules installed.
#
# Usage:
#   bash <(curl -fsSL https://raw.githubusercontent.com/bakwankawa/lazy-code-skill/refs/heads/main/.claude/scripts/install.sh)
#
# Or after cloning this repo locally:
#   bash .claude/lazy-code-skill/.claude/scripts/install.sh

set -euo pipefail

REPO_URL="https://github.com/bakwankawa/lazy-code-skill.git"
CLONE_DIR=".claude/lazy-code-skill"
SKILLS_DST=".claude/skills"
RULES_DST=".claude/rules"

echo "[1/7] Cloning lazy-code-skill..."
mkdir -p .claude
rm -rf "$CLONE_DIR"
git clone --depth 1 "$REPO_URL" "$CLONE_DIR"

echo "[2/7] Creating directories..."
mkdir -p "$SKILLS_DST" "$RULES_DST"

echo "[3/7] Copying skills (each skill as a directory)..."
rm -rf "${SKILLS_DST:?}"/*
# Iterate over directories only — never copy flat files.
for skill_dir in "$CLONE_DIR/.claude/skills"/*/; do
  [ -d "$skill_dir" ] || continue
  skill_name=$(basename "$skill_dir")
  cp -r "$skill_dir" "$SKILLS_DST/"
  echo "  + $skill_name"
done

echo "[4/7] Copying rules (with prefix lazy-code-skill-)..."
rm -f "$RULES_DST"/lazy-code-skill-*.mdc
for f in "$CLONE_DIR/.claude/rules"/*.mdc; do
  [ -f "$f" ] || continue
  cp "$f" "$RULES_DST/lazy-code-skill-$(basename "$f")"
  echo "  + lazy-code-skill-$(basename "$f")"
done

echo "[5/7] Copying project_architecture.md (only if missing)..."
if [ ! -f .claude/project_architecture.md ]; then
  cp "$CLONE_DIR/.claude/project_architecture.md" .claude/project_architecture.md
  echo "  + .claude/project_architecture.md"
else
  echo "  (skipped — already exists)"
fi

echo "[6/7] Copying README as lazy-code-skill-README.md..."
cp "$CLONE_DIR/README.md" .claude/lazy-code-skill-README.md
echo "  + .claude/lazy-code-skill-README.md"

echo "[7/7] Removing clone..."
rm -rf "$CLONE_DIR"

# ── Verification ──────────────────────────────────────────────────────────────
echo ""
echo "Verifying install..."

SKILL_COUNT=0
FLAT_FILE_COUNT=0
for item in "$SKILLS_DST"/*; do
  if [ -d "$item" ]; then
    SKILL_COUNT=$((SKILL_COUNT + 1))
  elif [ -f "$item" ]; then
    FLAT_FILE_COUNT=$((FLAT_FILE_COUNT + 1))
    echo "  WARNING: unexpected flat file found: $item"
  fi
done

if [ "$FLAT_FILE_COUNT" -gt 0 ]; then
  echo ""
  echo "ERROR: $FLAT_FILE_COUNT flat file(s) found in $SKILLS_DST/."
  echo "Each skill must be a directory (e.g. $SKILLS_DST/systematic-debugging/)."
  echo "The install did not complete correctly. Re-run this script."
  exit 1
fi

echo "  OK: $SKILL_COUNT skill directories installed."
echo ""
echo "Done! Skills are in $SKILLS_DST/, rules are in $RULES_DST/."
echo "Skills available: $(ls "$SKILLS_DST" | tr '\n' ' ')"
