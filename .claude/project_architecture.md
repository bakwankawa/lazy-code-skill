# Project Architecture

## Overview

This repo is a collection of **Claude skills and rules** installable at **project level**. Users run "Fetch and follow instructions from…" with the raw INSTALL.md URL; the agent clones the repo and copies skills and rules into the project's `.claude/`. No symlinks (copy-based only).

## Components

| Path | Role |
|------|------|
| `.claude/INSTALL.md` | Install instructions: clone, copy skills/rules, optional project_architecture template. |
| `.claude/skills/` | All skills flattened: own skills (dual-remote-push, efficient-code, latency-logging, new-project-scaffold, pre-commit-docs-sync, jira), superpowers (brainstorming, dispatching-parallel-agents, executing-plans, etc.), anthropic skills, and vercel-labs skills. |
| `.claude/rules/` | skill-first-engineering (single rule: skills first + deliberate, efficient implementation; replaces former efficient-and-deliberate and using-superpowers). |
| `.claude/scripts/` | sync-all-upstreams.sh (syncs all upstream skills directly into .claude/skills/). |
| `.claude/project_architecture.md` | Template for project architecture; copied on install if missing. |
| `.claude/lazy-code-skill-README.md` | Copy of repo README (Basic Workflow, install, sync); copied on install so it does not overwrite project README. |

## Data Flow

1. User pastes the raw INSTALL.md URL in Claude Agent.
2. Agent fetches INSTALL.md and runs: clone repo into `.claude/lazy-code-skill`, copy all skills (flattened directly to `.claude/skills/`), rules (replacing existing lazy-code-skill-*.mdc), and README (as `.claude/lazy-code-skill-README.md`); copy project_architecture.md only if missing. Then remove the clone. Re-running install force-updates skills, rules, and README; **`.claude/plans/` and `.claude/project_architecture.md` are never overwritten** if they already exist.
3. Claude discovers skills and rules from `.claude/skills/` and `.claude/rules/`.

## Deprecated / Removed

(Empty.)
