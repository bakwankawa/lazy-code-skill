---
name: pre-commit-docs-sync
description: Ensures README.md and .cursor/project_architecture.md are fully updated and accurate BEFORE a commit is created. Prevents commits from landing with outdated, incomplete, or misleading documentation.
---

# Skill: Pre-Commit Documentation Sync

## Purpose

Ensure project documentation is **fully aligned with code changes BEFORE committing**.  
This skill acts as a **pre-commit gate**, guaranteeing that **README.md** and **project_architecture.md** accurately reflect all new features, fixes, refactors, or removals introduced by the pending changes.

The commit should only proceed once documentation parity is achieved.

This skill is designed for **pre-commit discipline**, **documentation hygiene**, and **agent reliability**.

---

## When to Run

Run this skill **immediately before** a commit is created, when:

- The user is about to commit changes
- The user asks to prepare or review documentation before committing
- The user wants to ensure documentation is up to date prior to version control

Primary objective: **no commit without correct documentation**.

---

## Inputs & Sources of Truth

Use the following as the authoritative source of change:

- `git diff --staged` → primary source (changes about to be committed)
- `git diff` → only if explicitly requested by the user

Never infer changes from memory or assumptions—**only from diffs**.

---

## Execution Workflow

### Step 1: Analyze the Change Set

From the diff, classify changes into one or more of the following:

- **New Feature**
  - New modules, services, endpoints, configs, UI elements, or capabilities
- **Bug Fix**
  - Corrected behavior, logic errors, crashes, or incorrect outputs
- **Refactor**
  - Renames, file moves, or structural changes without behavior change
- **Removal / Deprecation**
  - Deleted features, APIs, flags, or obsolete workflows

Extract:
- What changed
- Where it changed
- How it affects users or system structure

---

### Step 2: Update `README.md`

**Location:** `README.md` (repository root)

#### Creation Rules
- If the file does not exist, create it.
- If it exists, update only relevant sections.

#### Required Updates
- **Project summary**
  - Adjust description if scope or capabilities changed
- **Features**
  - Add new features
  - Revise changed ones
  - Remove deprecated or deleted features
- **Setup / Usage**
  - Update commands, environment variables, configs, or workflows affected by the changes
- **Optional: Pending Changes**
  - Briefly mention impactful changes that will be included in the upcoming commit

#### Constraints
- Keep it concise and user-facing
- Do **not** duplicate architecture details
- Remove or rewrite any statement that is no longer true

---

### Step 3: Update `project_architecture.md`

**Location:** `.cursor/project_architecture.md`

#### Creation Rules
- Create `.cursor/` if missing
- Create `project_architecture.md` if missing

#### Required Sections
- **Overview**
  - High-level system description, updated to include new or modified components
- **Components / Modules**
  - Add new files, services, or layers
  - Update responsibilities of modified components
- **Data Flow / APIs**
  - Document new or changed endpoints, events, pipelines, or integrations
- **Deprecated / Removed**
  - Explicitly list removed or obsolete components (or fully delete them if no longer relevant)

#### Constraints
- Architecture-level detail only
- Clear, structured, agent-readable
- Avoid verbose explanations or tutorials

---

### Step 4: Validation Rules (Strict)

- ❌ Do NOT change code
- ❌ Do NOT create, amend, or execute commits
- ❌ Do NOT invent features, fixes, or future plans
- ❌ Do NOT allow the commit to proceed with stale documentation

Documentation must reflect **exactly what the staged diff proves**.

---

## Quality Checklist

Before allowing the commit, verify:

- [ ] Changes were derived strictly from `git diff --staged`
- [ ] README.md reflects current features and usage
- [ ] project_architecture.md reflects current structure and flow
- [ ] All deprecated or removed elements are handled
- [ ] No outdated, misleading, or speculative content remains

---

## File Reference

| Document | Path |
|--------|------|
| README | `README.md` |
| Architecture | `.cursor/project_architecture.md` |

---

## Expected Outcome

After running this skill:
- Documentation is **accurate, complete, and commit-ready**
- Commits never introduce documentation debt
- Future agents and developers can trust docs as a true representation of the codebase
