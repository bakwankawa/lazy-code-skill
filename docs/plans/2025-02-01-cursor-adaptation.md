# Cursor Adaptation Implementation Plan

> **For Cursor:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Adapt Superpowers skills (Claude/Codex references) so they work consistently in Cursor: paths, project conventions, description discovery, and subagent terminology.

**Architecture:** Edit-in-place in `.cursor/skills/superpowers/`. No new repos or services. Changes are text substitutions and one optional new file (Cursor testing variant). Preserve CSO/description principles; add Cursor paths and agent-agnostic wording.

**Tech Stack:** Markdown, YAML frontmatter, Cursor rules (`.mdc`), Git.

---

## Task 1: writing-skills/SKILL.md — Paths and agent-agnostic wording

**Files:**
- Modify: `.cursor/skills/superpowers/writing-skills/SKILL.md`

**Step 1: Add Cursor path and keep Claude/Codex (line ~12)**

Replace the single sentence about personal skills with:

```markdown
**Personal skills live in agent-specific directories (`~/.claude/skills` for Claude Code, `~/.codex/skills` for Codex). In Cursor, project skills live in `.cursor/skills/`.**
```

**Step 2: Make "What is a Skill?" agent-agnostic (line ~24)**

Replace:
`Skills help future Claude instances find and apply effective approaches.`

With:
`Skills help the agent (and future sessions) find and apply effective approaches.`

**Step 3: Add Cursor for project conventions (line ~58)**

Replace:
`Project-specific conventions (put in CLAUDE.md)`

With:
`Project-specific conventions (put in CLAUDE.md for Claude, or `.cursor/rules/` for Cursor)`

**Step 4: Commit**

```bash
git add .cursor/skills/superpowers/writing-skills/SKILL.md
git commit -m "docs(superpowers): add Cursor paths and agent-agnostic wording in writing-skills"
```

---

## Task 2: writing-skills/SKILL.md — CSO section (Claude → agent/Cursor)

**Files:**
- Modify: `.cursor/skills/superpowers/writing-skills/SKILL.md`

**Step 1: Rename section and update first line (~140–142)**

Replace:
`## Claude Search Optimization (CSO)`  
`**Critical for discovery:** Future Claude needs to FIND your skill`

With:
`## Agent Search Optimization (ASO)`  
`**Critical for discovery:** The agent needs to FIND your skill`

**Step 2: Replace "Claude reads" with "The agent reads" in Purpose (~146)**

Replace:
`**Purpose:** Claude reads description to decide which skills to load for a given task.`

With:
`**Purpose:** The agent reads description to decide which skills to load for a given task.`

**Step 3: Replace Claude references in "Why this matters" paragraph (~154–158)**

Replace the paragraph that starts with "**Why this matters:** Testing revealed..." so that every "Claude" in that paragraph becomes "the agent" (e.g. "the agent may follow", "the agent correctly read", "the trap: ... the agent will take", "documentation the agent skips").

**Step 4: Fix BAD example comment (~161)**

Replace:
`# ❌ BAD: Summarizes workflow - Claude may follow this instead of reading skill`

With:
`# ❌ BAD: Summarizes workflow - the agent may follow this instead of reading skill`

**Step 5: Keyword coverage line (~201)**

Replace:
`Use words Claude would search for:`

With:
`Use words the agent would search for:`

**Step 6: Discovery Workflow heading and line (~635–637)**

Replace:
`How future Claude finds your skill:`

With:
`How the agent finds your skill:`

**Step 7: Commit**

```bash
git add .cursor/skills/superpowers/writing-skills/SKILL.md
git commit -m "docs(superpowers): CSO → ASO, Claude → agent in writing-skills"
```

---

## Task 3: writing-skills/examples — Cursor variant

**Files:**
- Modify: `.cursor/skills/superpowers/writing-skills/examples/CLAUDE_MD_TESTING.md`

**Step 1: Add Cursor variant section at end of file**

Append a new section (after the last scenario/variant) titled `### Cursor variant` that states:

- Skills path: `.cursor/skills/` (project) instead of `~/.claude/skills/`.
- Project rules / “where to tell the agent to check skills”: `.cursor/rules/` (e.g. a rule that says “check `.cursor/skills/` before acting”) instead of CLAUDE.md.
- Same test scenarios (time pressure, sunk cost, authority, familiarity) apply; only paths and doc names change.

**Step 2: Commit**

```bash
git add .cursor/skills/superpowers/writing-skills/examples/CLAUDE_MD_TESTING.md
git commit -m "docs(superpowers): add Cursor variant to skills testing examples"
```

---

## Task 4: anthropic-best-practices.md — Cursor note and generic “agent”

**Files:**
- Modify: `.cursor/skills/superpowers/writing-skills/anthropic-best-practices.md`

**Step 1: Add Cursor note after the first blockquote (~line 5)**

After the opening blockquote, add one short paragraph:

```markdown
This document targets Anthropic's skill system. The same principles apply in Cursor: skills live in `.cursor/skills/`, and the description is used for Agent Decides (when to load the skill).
```

**Step 2: Replace generic “Claude” with “the agent”**

In the first ~100 lines, replace:
- `Claude reads SKILL.md` → `The agent reads SKILL.md`
- `Claude loads` → `The agent loads`
- `Claude may` / `Claude might` / `Claude uses` → `The agent may` / `The agent might` / `The agent uses`
- `Claude A` / `Claude B` → `Agent A` / `Agent B` (or “one instance” / “another instance” where it reads better)

Do not change: Anthropic product names in links (e.g. context window), or section titles that refer to “Claude” as the product. Only make the instructional voice agent-agnostic.

**Step 3: Commit**

```bash
git add .cursor/skills/superpowers/writing-skills/anthropic-best-practices.md
git commit -m "docs(superpowers): add Cursor note, agent-agnostic wording in best practices"
```

---

## Task 5: dispatching-parallel-agents/SKILL.md — Cursor dispatch

**Files:**
- Modify: `.cursor/skills/superpowers/dispatching-parallel-agents/SKILL.md`

**Step 1: Replace Claude Code snippet (~66–73)**

Replace the entire code block:

```typescript
// In Claude Code / AI environment
Task("Fix agent-tool-abort.test.ts failures")
Task("Fix batch-completion-behavior.test.ts failures")
Task("Fix tool-approval-race-conditions.test.ts failures")
// All three run concurrently
```

With:

```markdown
In Cursor: use parallel agents or dispatch one subagent per task with the given scope (see Cursor docs: Subagents, Parallel Agents). Example scope per task:

- Task 1: Fix agent-tool-abort.test.ts failures
- Task 2: Fix batch-completion-behavior.test.ts failures
- Task 3: Fix tool-approval-race-conditions.test.ts failures

Dispatch all three in parallel (or sequentially if your environment prefers).
```

**Step 2: Commit**

```bash
git add .cursor/skills/superpowers/dispatching-parallel-agents/SKILL.md
git commit -m "docs(superpowers): Cursor subagents/parallel agents in dispatching-parallel-agents"
```

---

## Task 6: subagent-driven-development/SKILL.md — Cursor Subagents note

**Files:**
- Modify: `.cursor/skills/superpowers/subagent-driven-development/SKILL.md`

**Step 1: Add Cursor note after Overview (~line 10)**

After the line "**Core principle:** Fresh subagent per task + two-stage review...", add:

```markdown
**In Cursor:** Subagents are available via the Subagents feature; dispatch by starting a subagent with the given prompt/context (e.g. implementer or reviewer prompts in this skill).
```

**Step 2: Commit**

```bash
git add .cursor/skills/superpowers/subagent-driven-development/SKILL.md
git commit -m "docs(superpowers): add Cursor Subagents note in subagent-driven-development"
```

---

## Remember

- Exact file paths as above; no extra files unless you add the optional `CURSOR_SKILLS_TESTING.md` (plan allows in-file Cursor variant only).
- DRY, YAGNI; each task is one logical edit + commit.
- Reference skills with superpowers: name where relevant.

---

## Execution Handoff

After saving this plan, offer:

**Plan complete and saved to `docs/plans/2025-02-01-cursor-adaptation.md`. Two execution options:**

**1. Subagent-Driven (this session)** — I dispatch a fresh subagent per task, review between tasks, fast iteration.

**2. Parallel Session (separate)** — Open a new session in the worktree and use superpowers:executing-plans for batch execution with checkpoints.

**Which approach?**
