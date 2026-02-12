# lazy-code-skill

## 1. Project Overview

**What it does:** Collection of agent **skills** and **rules** in mirrored namespaces for both Cursor (`.cursor/...`) and Codex (`.codex/...`). Includes four skill namespaces: `lazy-code-skill` (own: pre-commit docs sync, new-project scaffold, dual-remote push, efficient code, latency logging, jira skill collection), `superpowers` (from [Superpowers](https://github.com/obra/superpowers): brainstorming, writing-plans, TDD, debugging, code review, git worktrees, etc.), `anthropic` (from [anthropics/skills](https://github.com/anthropics/skills): synced example skills), and `vercel-labs` (from [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills/tree/main/skills): synced skills). One **rule**: **skill-first-engineering** (skills first + deliberate, efficient implementation). Install at **project level** for Cursor or Codex projects.

**Upstream skill namespaces:** Agents discover skills under `.cursor/skills/<namespace>/<skill-name>/SKILL.md` (Cursor) or `.codex/skills/<namespace>/<skill-name>/SKILL.md` (Codex). Namespaces synced from upstream in this repo: `anthropic` and `vercel-labs`.

**Who it is for:** Developers using Cursor or Codex who want shared workflows and standards (docs sync, scaffolding, dual-remote push, etc.) in their projects.

---

## 2. Prerequisites

- **Cursor** (with Agent) or **Codex**
- **git** (to clone this repo during install)

No minimum version required beyond a recent release that supports skills and rules.

---

## 3. Environment Setup

No environment variables or `.env` files are required to install or use these skills. Installation is copy-based into your project’s `.cursor/` or `.codex/` directory.

---

## 4. How to Run / Use (Install into Your Project)

Run these steps from the **root of the project** where you want the skills and rules.

### Step 1: Trigger install via agent

In your agent chat, paste and send one of these:

```
Fetch and follow instructions from https://raw.githubusercontent.com/bakwankawa/lazy-code-skill/refs/heads/main/.cursor/INSTALL.md
```

For Codex:

```
Fetch and follow instructions from https://raw.githubusercontent.com/bakwankawa/lazy-code-skill/refs/heads/main/.codex/INSTALL.md
```

**Success:** The agent fetches INSTALL.md and will run the install steps below.

### Step 2: Agent runs install (or run manually)

The agent will (or you can run from project root):

1. Clone this repo into `.cursor/lazy-code-skill` (Cursor) or `.codex/lazy-code-skill` (Codex)
2. Create `skills` and `rules` directories in the selected namespace
3. Copy all four skill folders to `.../skills/lazy-code-skill/`, `.../skills/superpowers/`, `.../skills/anthropic/`, and `.../skills/vercel-labs/`
4. Copy rules to `.../rules/` with prefix `lazy-code-skill-`
5. Copy `project_architecture.md` only if missing (never overwrite if user already has it)
6. Copy README to `.../lazy-code-skill-README.md` (Basic Workflow reference)
7. Remove the clone so only skills, rules, and README copy remain. `.../plans/` and `.../project_architecture.md` are never overwritten if they exist.

**Success:** You have either `.cursor/skills/...` + `.cursor/rules/` or `.codex/skills/...` + `.codex/rules/`. The selected agent discovers them automatically.

### Step 3: Use skills and rules

- **Skills:** In agent settings/rules, set to Agent Decides, or invoke via `/skill-name` (e.g. `/pre-commit-docs-sync`, `/dual-remote-push`).
- **Rules:** Active for the project; loaded from `.cursor/rules/` or `.codex/rules/`.

**Direct links to install instructions:**
- Cursor: [.cursor/INSTALL.md](https://raw.githubusercontent.com/bakwankawa/lazy-code-skill/refs/heads/main/.cursor/INSTALL.md)
- Codex: [.codex/INSTALL.md](https://raw.githubusercontent.com/bakwankawa/lazy-code-skill/refs/heads/main/.codex/INSTALL.md)

---

## 5. How to Run (Docker / Containerized)

Not applicable. This repo is skills and rules only; there is no application to run in Docker.

---

## 6. Configuration & Runtime Behavior

- **Skills** are invoked by the agent when relevant or manually via `/skill-name`.
- **Rules** (e.g. `lazy-code-skill-skill-first-engineering.mdc`) apply at project level when the agent loads the project.
- **Updating:** Re-run the full install (steps in section 4) to force-update skills, rules, and README copy in the namespace you use. Update is non-destructive: only `skills/lazy-code-skill`, `skills/superpowers`, `skills/anthropic`, `skills/vercel-labs`, prefixed rules, README copy, and temporary clone path are touched. Other folders (for example `conversations/`, `docs/`, `plans/`, `reviews/`, `test/`, custom folders) are preserved.

---

## Basic Workflow (from Superpowers — use as reference)

When you use the Superpowers-style skills, this is the intended order. The agent checks for relevant skills before any task. Mandatory workflows, not suggestions.

1. **brainstorming** — Before writing code. Refines rough ideas through questions, explores alternatives, presents design in sections for validation. Saves design document.

2. **using-git-worktrees** — After design approval. Creates isolated workspace on new branch, runs project setup, verifies clean test baseline.

3. **writing-plans** — With approved design. Breaks work into bite-sized tasks (2–5 minutes each). Every task has exact file paths, complete code, verification steps. **If you will execute in a worktree (option 2):** open the worktree folder in your agent workspace first, then run writing-plans there so the plan is saved in that workspace.

4. **subagent-driven-development** or **executing-plans** — With a plan. Dispatches fresh subagent per task with two-stage review (spec compliance, then code quality), or executes in batches with human checkpoints.

5. **test-driven-development** — During implementation. Enforces RED-GREEN-REFACTOR: write failing test, watch it fail, write minimal code, watch it pass, commit. Deletes code written before tests.

6. **requesting-code-review** — Between tasks. Reviews against plan, reports issues by severity. Critical issues block progress.

7. **finishing-a-development-branch** — When tasks complete. Verifies tests, presents options (merge/PR/keep/discard), cleans up worktree.

**To update skills from Superpowers:** Run one of these sync scripts from repo root:  
`./.cursor/scripts/sync-superpowers-skills.sh` (Cursor namespace)  
`./.codex/scripts/sync-superpowers-skills.sh` (Codex namespace)  
(from the repo root). Then review and commit.

**To update Anthropic skills:** Only in this repo (lazy-code-skill). Run one of these from repo root, then review and commit:  
`./.cursor/scripts/sync-anthropic-skills.sh` or `./.codex/scripts/sync-anthropic-skills.sh`. Installing projects get the synced copy; they do not run the script.

**To update Vercel Labs skills:** Only in this repo (lazy-code-skill). Run one of these from repo root, then review and commit:  
`./.cursor/scripts/sync-vercel-labs-skills.sh` or `./.codex/scripts/sync-vercel-labs-skills.sh`. Installing projects get the synced copy; they do not run the script.

**To update all upstream namespaces at once:**  
`./.cursor/scripts/sync-all-upstreams.sh` (Cursor namespace) or `./.codex/scripts/sync-all-upstreams.sh` (Codex namespace). This runs Superpowers + Anthropic + Vercel Labs sync sequentially in one command.

---

## 7. Common Changes Introduced by This Commit

- **Install: copy README on install.** INSTALL.md includes step 6: copy repo README to `lazy-code-skill-README.md` in the selected namespace (`.cursor/` or `.codex/`) so Basic Workflow and sync instructions are available without overwriting the project's README.
- **project_architecture.md:** Data flow and Components include `lazy-code-skill-README.md` and all four skill namespaces; installation copies all four skill folders in the selected namespace.
- **Agent adaptation (Superpowers):** Superpowers skills include project-local paths and agent-agnostic wording for repo usage across Cursor and Codex namespaces.
- **Upstream skill namespaces:** Four namespaces (lazy-code-skill, superpowers, anthropic, vercel-labs). `anthropic` is synced from [anthropics/skills](https://github.com/anthropics/skills) and `vercel-labs` is synced from [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills/tree/main/skills) via the corresponding sync scripts in `.cursor/scripts/` or `.codex/scripts/` (maintainers of this repo only). Install copies all four skill folders.
- **Jira skill collection:** Added Jira skill under `lazy-code-skill/jira` (in both namespaces), mirroring upstream Jira skill references for conversational Jira operations via jira CLI or Atlassian MCP.

---

## Repo

[https://github.com/bakwankawa/lazy-code-skill](https://github.com/bakwankawa/lazy-code-skill)
