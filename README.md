# lazy-code-skill

## 1. Project Overview

**What it does:** Collection of Cursor **skills** and **rules**: includes [Superpowers](https://github.com/obra/superpowers)-style workflow skills (brainstorming, writing-plans, TDD, debugging, code review, git worktrees, etc.) plus own skills (pre-commit docs sync, new-project scaffold, dual-remote push, efficient code, latency logging). **using-superpowers** is a rule (invoke relevant skills before response). Install at **project level** so any Cursor project can use them.

**Who it is for:** Developers using Cursor who want shared workflows and standards (docs sync, scaffolding, dual-remote push, etc.) in their projects.

---

## 2. Prerequisites

- **Cursor** (with Agent)
- **git** (to clone this repo during install)

No minimum version required beyond a recent Cursor release that supports skills and rules.

---

## 3. Environment Setup

No environment variables or `.env` files are required to install or use these skills. Installation is copy-based into your project’s `.cursor/` directory.

---

## 4. How to Run / Use (Install into Your Project)

Run these steps from the **root of the project** where you want the skills and rules.

### Step 1: Trigger install via Cursor Agent

In **Cursor Agent chat**, paste and send:

```
Fetch and follow instructions from https://raw.githubusercontent.com/bakwankawa/lazy-code-skill/refs/heads/main/.cursor/INSTALL.md
```

**Success:** The agent fetches INSTALL.md and will run the install steps below.

### Step 2: Agent runs install (or run manually)

The agent will (or you can run from project root):

1. Clone this repo into `.cursor/lazy-code-skill`
2. Create `.cursor/skills` and `.cursor/rules`
3. Copy skills to `.cursor/skills/lazy-code-skill/`
4. Copy rules to `.cursor/rules/` with prefix `lazy-code-skill-`
5. Optionally copy `.cursor/project_architecture.md` if your project doesn’t have it
6. Remove the clone (`.cursor/lazy-code-skill`) so only skills and rules remain

**Success:** You have `.cursor/skills/lazy-code-skill/` and `.cursor/rules/lazy-code-skill-*.mdc`. Cursor discovers them automatically.

### Step 3: Use skills and rules

- **Skills:** Cursor Settings → Rules → Agent Decides, or in Agent chat type `/skill-name` (e.g. `/pre-commit-docs-sync`, `/dual-remote-push`).
- **Rules:** Active for the project; loaded from `.cursor/rules/`.

**Direct link to install instructions:** [.cursor/INSTALL.md](https://raw.githubusercontent.com/bakwankawa/lazy-code-skill/refs/heads/main/.cursor/INSTALL.md)

---

## 5. How to Run (Docker / Containerized)

Not applicable. This repo is Cursor skills and rules only; there is no application to run in Docker.

---

## 6. Configuration & Runtime Behavior

- **Skills** are invoked by the agent when relevant or manually via `/skill-name`.
- **Rules** (e.g. `lazy-code-skill-efficient-and-deliberate.mdc`, `lazy-code-skill-using-superpowers.mdc`) apply at project level when Cursor loads the project.
- **Updating:** Re-run the full install (steps in section 4) to get the latest skills and rules; the clone is removed after install.

---

## Basic Workflow (from Superpowers — use as reference)

When you use the Superpowers-style skills, this is the intended order. The agent checks for relevant skills before any task. Mandatory workflows, not suggestions.

1. **brainstorming** — Before writing code. Refines rough ideas through questions, explores alternatives, presents design in sections for validation. Saves design document.

2. **using-git-worktrees** — After design approval. Creates isolated workspace on new branch, runs project setup, verifies clean test baseline.

3. **writing-plans** — With approved design. Breaks work into bite-sized tasks (2–5 minutes each). Every task has exact file paths, complete code, verification steps.

4. **subagent-driven-development** or **executing-plans** — With a plan. Dispatches fresh subagent per task with two-stage review (spec compliance, then code quality), or executes in batches with human checkpoints.

5. **test-driven-development** — During implementation. Enforces RED-GREEN-REFACTOR: write failing test, watch it fail, write minimal code, watch it pass, commit. Deletes code written before tests.

6. **requesting-code-review** — Between tasks. Reviews against plan, reports issues by severity. Critical issues block progress.

7. **finishing-a-development-branch** — When tasks complete. Verifies tests, presents options (merge/PR/keep/discard), cleans up worktree.

**To update skills from Superpowers:** In Cursor Agent, ask the agent to run the sync script:  
`./.cursor/scripts/sync-superpowers-skills.sh`  
(from the repo root). Then review and commit.

---

## 7. Common Changes Introduced by This Commit

- **Superpowers import:** 13 skills from [obra/superpowers](https://github.com/obra/superpowers) (brainstorming, writing-plans, TDD, debugging, code review, git worktrees, etc.) synced into `.cursor/skills/`. **using-superpowers** added as a **rule** in `.cursor/rules/` (invoke relevant skills before response).
- **Sync script:** `.cursor/scripts/sync-superpowers-skills.sh` — run to pull latest from Superpowers and update skills; instruct the agent to run it when you want to update.
- **README:** Basic Workflow section added (from Superpowers) as reference; overview and rules list updated.

---

## Repo

[https://github.com/bakwankawa/lazy-code-skill](https://github.com/bakwankawa/lazy-code-skill)
