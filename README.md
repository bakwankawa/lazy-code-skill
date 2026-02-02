# lazy-code-skill

## 1. Project Overview

**What it does:** Collection of Cursor **skills** and **rules** (efficient code, pre-commit docs sync, new-project scaffolding, dual-remote push, debugging, TDD). Install at **project level** so any Cursor project can use them.

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
- **Rules** (e.g. `lazy-code-skill-efficient-and-deliberate.mdc`) apply at project level when Cursor loads the project.
- **Updating:** Re-run the full install (steps in section 4) to get the latest skills and rules; the clone is removed after install.

---

## 7. Common Changes Introduced by This Commit

- **pre-commit-docs-sync** skill updated: README.md must now function as a **complete SOP** (Project Overview, Prerequisites, Environment Setup, How to Run Local/Docker, Configuration, Common Changes). README is enforced as a standalone operational guide, not a summary.

---

## Repo

[https://github.com/bakwankawa/lazy-code-skill](https://github.com/bakwankawa/lazy-code-skill)
