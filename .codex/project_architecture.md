# Project Architecture

## Overview

This repo is a collection of **Codex skills and rules** installable at **project level**. Users run "Fetch and follow instructions from…" with the raw INSTALL.md URL; the agent clones the repo and copies skills and rules into the project’s `.codex/`. No symlinks (copy-based only).

## Components

| Path | Role |
|------|------|
| `.codex/INSTALL.md` | Install instructions: clone, copy skills/rules, optional project_architecture template. |
| `.codex/skills/lazy-code-skill/` | Own skills: dual-remote-push, efficient-code, latency-logging, new-project-scaffold, pre-commit-docs-sync, jira skill collection. |
| `.codex/skills/superpowers/` | From obra/superpowers: brainstorming, dispatching-parallel-agents, executing-plans, finishing-a-development-branch, receiving-code-review, requesting-code-review, subagent-driven-development, systematic-debugging, test-driven-development, using-git-worktrees, verification-before-completion, writing-plans, writing-skills. |
| `.codex/skills/anthropic/` | From anthropics/skills: all example skills; synced via sync-anthropic-skills.sh. |
| `.codex/rules/` | skill-first-engineering (single rule: skills first + deliberate, efficient implementation; replaces former efficient-and-deliberate and using-superpowers). |
| `.codex/scripts/` | sync-superpowers-skills.sh (superpowers); sync-anthropic-skills.sh (anthropics/skills into .codex/skills/anthropic/). |
| `.codex/project_architecture.md` | Template for project architecture; copied on install if missing. |
| `.codex/lazy-code-skill-README.md` | Copy of repo README (Basic Workflow, install, sync); copied on install so it does not overwrite project README. |

## Data Flow

1. User pastes the raw INSTALL.md URL in Codex Agent.
2. Agent fetches INSTALL.md and runs: clone repo into `.codex/lazy-code-skill`, copy all three skill folders (lazy-code-skill, superpowers, anthropic), rules (replacing existing lazy-code-skill-*.mdc), and README (as `.codex/lazy-code-skill-README.md`); copy project_architecture.md only if missing. Then remove the clone. Re-running install force-updates skills, rules, and README; **`.codex/plans/` and `.codex/project_architecture.md` are never overwritten** if they already exist.
3. Codex discovers skills and rules from `.codex/skills/` and `.codex/rules/`.

## Deprecated / Removed

(Empty.)
