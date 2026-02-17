# lazy-code-skill

## 1. Project Overview

**What it does:** Collection of agent **skills** and **rules** in mirrored namespaces for Cursor (`.cursor/...`), Codex (`.codex/...`), and Claude (`.claude/...`). Includes skills from multiple sources: own skills (pre-commit docs sync, new-project scaffold, dual-remote push, efficient code, latency logging, jira skill collection), Superpowers (brainstorming, writing-plans, TDD, debugging, code review, git worktrees, etc.), Anthropic (synced example skills), and Vercel Labs (synced skills). One **rule**: **skill-first-engineering** (skills first + deliberate, efficient implementation). Install at **project level** for Cursor, Codex, or Claude projects.

**Skill structure:** Skills are flattened directly under `.cursor/skills/<skill-name>/SKILL.md`, `.codex/skills/<skill-name>/SKILL.md`, or `.claude/skills/<skill-name>/SKILL.md`.

**Who it is for:** Developers using Cursor, Codex, or Claude who want shared workflows and standards (docs sync, scaffolding, dual-remote push, etc.) in their projects.

---

## 2. Prerequisites

- **Cursor** (with Agent), **Codex**, or **Claude**
- **git** (to clone this repo during install)

No minimum version required beyond a recent release that supports skills and rules.

---

## 3. Environment Setup

No environment variables or `.env` files are required to install or use these skills. Installation is copy-based into your project's `.cursor/`, `.codex/`, or `.claude/` directory.

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

For Claude:

```
Fetch and follow instructions from https://raw.githubusercontent.com/bakwankawa/lazy-code-skill/refs/heads/main/.claude/INSTALL.md
```

**Success:** The agent fetches INSTALL.md and will run the install steps below.

### Step 2: Agent runs install (or run manually)

The agent will (or you can run from project root):

1. Clone this repo into `.cursor/lazy-code-skill` (Cursor), `.codex/lazy-code-skill` (Codex), or `.claude/lazy-code-skill` (Claude)
2. Create `skills` and `rules` directories in the selected namespace
3. Copy all skills (flattened directly to `.../skills/`)
4. Copy rules to `.../rules/` with prefix `lazy-code-skill-`
5. Copy `project_architecture.md` only if missing (never overwrite if user already has it)
6. Copy README to `.../lazy-code-skill-README.md` (Basic Workflow reference)
7. Remove the clone so only skills, rules, and README copy remain. `.../plans/` and `.../project_architecture.md` are never overwritten if they exist.

**Success:** You have either `.cursor/skills/...` + `.cursor/rules/`, `.codex/skills/...` + `.codex/rules/`, or `.claude/skills/...` + `.claude/rules/`. The selected agent discovers them automatically.

### Step 3: Use skills and rules

- **Skills:** In agent settings/rules, set to Agent Decides, or invoke via `/skill-name` (e.g. `/pre-commit-docs-sync`, `/dual-remote-push`).
- **Rules:** Active for the project; loaded from `.cursor/rules/`, `.codex/rules/`, or `.claude/rules/`.

**Direct links to install instructions:**
- Cursor: [.cursor/INSTALL.md](https://raw.githubusercontent.com/bakwankawa/lazy-code-skill/refs/heads/main/.cursor/INSTALL.md)
- Codex: [.codex/INSTALL.md](https://raw.githubusercontent.com/bakwankawa/lazy-code-skill/refs/heads/main/.codex/INSTALL.md)
- Claude: [.claude/INSTALL.md](https://raw.githubusercontent.com/bakwankawa/lazy-code-skill/refs/heads/main/.claude/INSTALL.md)

---

## 5. How to Run (Docker / Containerized)

Not applicable. This repo is skills and rules only; there is no application to run in Docker.

---

## 6. Configuration & Runtime Behavior

- **Skills** are invoked by the agent when relevant or manually via `/skill-name`.
- **Rules** (e.g. `lazy-code-skill-skill-first-engineering.mdc`) apply at project level when the agent loads the project.
- **Updating:** Re-run the full install (steps in section 4) to force-update skills, rules, and README copy in the namespace you use. Update is non-destructive: only `skills/*`, prefixed rules, README copy, and temporary clone path are touched. Other folders (for example `conversations/`, `docs/`, `plans/`, `reviews/`, `test/`, custom folders) are preserved.

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

**To update all upstream skills at once:** Run one of these sync scripts from repo root, then review and commit:
`./.cursor/scripts/sync-all-upstreams.sh` (Cursor namespace)
`./.codex/scripts/sync-all-upstreams.sh` (Codex namespace)
`./.claude/scripts/sync-all-upstreams.sh` (Claude namespace)

This syncs all upstream skills (Superpowers, Anthropic, Vercel Labs) directly into `skills/`. Installing projects get the synced copy; they do not run these scripts.

---

## 7. Common Changes Introduced by This Commit

- **Skills flattened:** All skills are now flattened directly under `skills/<skill-name>/` instead of nested under namespace folders (`skills/namespace/<skill-name>/`). This matches Claude Code's expected skill discovery structure.
- **Install: copy README on install.** INSTALL.md includes step 6: copy repo README to `lazy-code-skill-README.md` in the selected namespace (`.cursor/`, `.codex/`, or `.claude/`) so Basic Workflow and sync instructions are available without overwriting the project's README.
- **project_architecture.md:** Data flow and Components include `lazy-code-skill-README.md` and flattened skills structure; installation copies all skills directly to `skills/`.
- **Agent adaptation (Superpowers):** Superpowers skills include project-local paths and agent-agnostic wording for repo usage across Cursor, Codex, and Claude namespaces.
- **Upstream skills:** Skills synced from Superpowers, Anthropic, and Vercel Labs are all flattened into `skills/` via `sync-all-upstreams.sh` in each namespace (maintainers of this repo only). Install copies all skills directly.
- **Jira skill collection:** Added Jira skill (in all namespaces), mirroring upstream Jira skill references for conversational Jira operations via jira CLI or Atlassian MCP.

---

## Repo

[https://github.com/bakwankawa/lazy-code-skill](https://github.com/bakwankawa/lazy-code-skill)
