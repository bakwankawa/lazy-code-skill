#!/usr/bin/env bash
# Sync all upstream skill namespaces for Codex in one command.
# Run from repo root.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

cd "$REPO_ROOT"

echo "[1/3] Syncing Superpowers..."
bash .codex/scripts/sync-superpowers-skills.sh

echo "[2/3] Syncing Anthropic..."
bash .codex/scripts/sync-anthropic-skills.sh

echo "[3/3] Syncing Vercel Labs..."
bash .codex/scripts/sync-vercel-labs-skills.sh

echo "Done. Codex upstream namespaces are synced."
