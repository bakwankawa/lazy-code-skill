# Project Architecture

## Overview

This repo is a collection of **Cursor skills and rules** installable at **project level**. Users run "Fetch and follow instructions from…" with the raw INSTALL.md URL; the agent clones the repo and copies skills and rules into the project’s `.cursor/`. No symlinks (copy-based only).

## Components

| Path | Role |
|------|------|
| `.cursor/INSTALL.md` | Install instructions: clone, copy skills/rules, optional project_architecture template. |
| `.cursor/skills/` | Superpowers: brainstorming, dispatching-parallel-agents, executing-plans, finishing-a-development-branch, receiving-code-review, requesting-code-review, subagent-driven-development, systematic-debugging, test-driven-development, using-git-worktrees, verification-before-completion, writing-plans, writing-skills. Own: dual-remote-push, efficient-code, latency-logging, new-project-scaffold, pre-commit-docs-sync. |
| `.cursor/rules/` | efficient-and-deliberate (efficiency, deliberate implementation); using-superpowers (invoke skills before response; from Superpowers). |
| `.cursor/scripts/` | sync-superpowers-skills.sh: pulls from obra/superpowers and copies skills into .cursor/skills/. |
| `.cursor/project_architecture.md` | Template for project architecture; copied on install if missing. |
| `.cursor/lazy-code-skill-README.md` | Copy of repo README (Basic Workflow, install, sync); copied on install so it does not overwrite project README. |

## Data Flow

1. User pastes the raw INSTALL.md URL in Cursor Agent.
2. Agent fetches INSTALL.md and runs: clone repo into `.cursor/lazy-code-skill`, copy skills, rules, and README (as `.cursor/lazy-code-skill-README.md` for Basic Workflow reference), then remove the clone so only `.cursor/skills/lazy-code-skill/`, `.cursor/rules/lazy-code-skill-*.mdc`, and `.cursor/lazy-code-skill-README.md` remain.
3. Cursor discovers skills and rules from `.cursor/skills/` and `.cursor/rules/`.

## Deprecated / Removed

(Empty.)
