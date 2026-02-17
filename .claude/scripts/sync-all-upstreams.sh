#!/usr/bin/env bash
# Sync all upstream skills for Claude in one command (flattened to .claude/skills/).
# Run from repo root.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

cd "$REPO_ROOT"

echo "[1/3] Syncing Superpowers..."
bash .claude/scripts/sync-superpowers-skills.sh

echo "[2/3] Syncing Anthropic..."
bash .claude/scripts/sync-anthropic-skills.sh

echo "[3/3] Syncing Vercel Labs..."
bash .claude/scripts/sync-vercel-labs-skills.sh

echo "Done. All upstream skills synced to .claude/skills/ (flattened)."
