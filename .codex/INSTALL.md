# Installing lazy-code-skill for Codex

Quick setup to enable lazy-code-skill rules and skills in Codex at **project level**.

> **Important:** Codex does not discover symlinked rules or skills. This installation uses copy-based setup. The cloned repo is removed after copy (step 7). To update, re-run the full installation (see Updating).
>
> **Re-run = force update:** Running the install again overwrites skills, rules, and the README copy so your `.codex/` matches the latest lazy-code-skill repo. **`.codex/plans/` and `.codex/project_architecture.md` are never overwritten** — if they exist, their contents are left unchanged.
>
> **Safe update guarantee:** This process does **not** delete other folders in `.codex/`. It only modifies:
> - `.codex/skills/lazy-code-skill`
> - `.codex/skills/superpowers`
> - `.codex/skills/anthropic`
> - `.codex/rules/lazy-code-skill-*.mdc`
> - `.codex/lazy-code-skill-README.md`
> - Temporary clone folder `.codex/lazy-code-skill` (removed at the end)
>
> Other paths like `.codex/conversations/`, `.codex/docs/`, `.codex/plans/`, `.codex/reviews/`, `.codex/test/`, and any custom folders are preserved.

## Installation (project-level)

Run these commands from your **project root** (the directory that will contain `.codex/`).

### 1. Clone the repository

```bash
mkdir -p .codex
git clone https://github.com/bakwankawa/lazy-code-skill.git .codex/lazy-code-skill
```

Use branch `main`; if your clone defaults to another branch, run `git -C .codex/lazy-code-skill checkout main` after cloning.

### 2. Create directories

```bash
mkdir -p .codex/skills .codex/rules
```

### 3. Copy skills (three namespaces)

Copy all three skill folders: `.codex/skills/lazy-code-skill/` (own), `.codex/skills/superpowers/` (from [Superpowers](https://github.com/obra/superpowers)), and `.codex/skills/anthropic/` (from [anthropics/skills](https://github.com/anthropics/skills)):

```bash
rm -rf .codex/skills/lazy-code-skill .codex/skills/superpowers .codex/skills/anthropic
cp -r .codex/lazy-code-skill/.codex/skills/lazy-code-skill .codex/skills/
cp -r .codex/lazy-code-skill/.codex/skills/superpowers .codex/skills/
cp -r .codex/lazy-code-skill/.codex/skills/anthropic .codex/skills/
```

On Windows (PowerShell):

```powershell
Remove-Item -Recurse -Force .codex/skills/lazy-code-skill, .codex/skills/superpowers, .codex/skills/anthropic -ErrorAction SilentlyContinue
Copy-Item -Recurse .codex/lazy-code-skill/.codex/skills/lazy-code-skill .codex/skills/
Copy-Item -Recurse .codex/lazy-code-skill/.codex/skills/superpowers .codex/skills/
Copy-Item -Recurse .codex/lazy-code-skill/.codex/skills/anthropic .codex/skills/
```

### 4. Copy rules (with prefix, force update)

Remove existing lazy-code-skill rules so only the latest rules from the repo remain; then copy each rule file with prefix `lazy-code-skill-`:

```bash
rm -f .codex/rules/lazy-code-skill-*.mdc
for f in .codex/lazy-code-skill/.codex/rules/*.mdc; do
  [ -f "$f" ] && cp "$f" ".codex/rules/lazy-code-skill-$(basename "$f")"
done
```

On Windows (PowerShell):

```powershell
Remove-Item .codex/rules/lazy-code-skill-*.mdc -ErrorAction SilentlyContinue
Get-ChildItem .codex/lazy-code-skill/.codex/rules/*.mdc | ForEach-Object {
  Copy-Item $_.FullName ".codex/rules/lazy-code-skill-$($_.Name)"
}
```

### 5. (Optional) Copy project_architecture.md template

Copy only if your project does not already have `.codex/project_architecture.md` — if it exists, it is left unchanged.

```bash
[ -f .codex/project_architecture.md ] || cp .codex/lazy-code-skill/.codex/project_architecture.md .codex/project_architecture.md
```

On Windows (PowerShell):

```powershell
if (-not (Test-Path .codex/project_architecture.md)) { Copy-Item .codex/lazy-code-skill/.codex/project_architecture.md .codex/project_architecture.md }
```

### 6. Copy README (Basic Workflow reference)

Copy the lazy-code-skill README into `.codex/` so you have the Basic Workflow and install reference without overwriting your project’s README:

```bash
cp .codex/lazy-code-skill/README.md .codex/lazy-code-skill-README.md
```

On Windows (PowerShell):

```powershell
Copy-Item .codex/lazy-code-skill/README.md .codex/lazy-code-skill-README.md
```

You can open `.codex/lazy-code-skill-README.md` anytime for the Basic Workflow (brainstorming → writing-plans → TDD → etc.) and sync instructions.

### 7. Remove the cloned repo

After copying, remove the clone so only skills, rules, and the README copy remain. (`.codex/plans/` and `.codex/project_architecture.md` are never created or overwritten by this install if they already exist.)

```bash
rm -rf .codex/lazy-code-skill
```

On Windows (PowerShell):

```powershell
Remove-Item -Recurse -Force .codex/lazy-code-skill
```

## Usage

- **Skills** appear under Codex Settings → Rules → Agent Decides. They can also be invoked manually in Agent chat with `/skill-name` (e.g. `/pre-commit-docs-sync`, `/dual-remote-push`).
- **Rules** are active for the project; Codex loads them from `.codex/rules/`.

## Updating

Re-run the same installation (steps 1–7) to **force update** your `.codex/` to match the latest lazy-code-skill repo: clone again, then copy skills, rules, and README (overwriting existing). **Only the paths listed in "Safe update guarantee" are touched.** Other `.codex/` folders stay unchanged.

## Updating Anthropic skills (maintainers of this repo only)

In the **lazy-code-skill repo** (not in projects that install it), run the sync script to refresh `.codex/skills/anthropic/` from [anthropics/skills](https://github.com/anthropics/skills):

```bash
bash .codex/scripts/sync-anthropic-skills.sh
```

Then review and commit. Downstream projects that install this repo do not run this script; they receive the already-synced copy when they install or update.
