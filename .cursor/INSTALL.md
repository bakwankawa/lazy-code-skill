# Installing lazy-code-skill for Cursor

Quick setup to enable lazy-code-skill rules and skills in Cursor at **project level**.

> **Important:** Cursor does not discover symlinked rules or skills. This installation uses copy-based setup. The cloned repo is removed after copy (step 7). To update, re-run the full installation (see Updating).
>
> **Re-run = force update:** Running the install again overwrites skills, rules, and the README copy so your `.cursor/` matches the latest lazy-code-skill repo. **`.cursor/plans/` and `.cursor/project_architecture.md` are never overwritten** — if they exist, their contents are left unchanged.

## Installation (project-level)

Run these commands from your **project root** (the directory that will contain `.cursor/`).

### 1. Clone the repository

```bash
mkdir -p .cursor
git clone https://github.com/bakwankawa/lazy-code-skill.git .cursor/lazy-code-skill
```

Use branch `main`; if your clone defaults to another branch, run `git -C .cursor/lazy-code-skill checkout main` after cloning.

### 2. Create directories

```bash
mkdir -p .cursor/skills .cursor/rules
```

### 3. Copy skills (two namespaces)

Copy both skill folders so you get `.cursor/skills/lazy-code-skill/` (own skills) and `.cursor/skills/superpowers/` (from [Superpowers](https://github.com/obra/superpowers)):

```bash
rm -rf .cursor/skills/lazy-code-skill .cursor/skills/superpowers
cp -r .cursor/lazy-code-skill/.cursor/skills/lazy-code-skill .cursor/skills/
cp -r .cursor/lazy-code-skill/.cursor/skills/superpowers .cursor/skills/
```

On Windows (PowerShell):

```powershell
Remove-Item -Recurse -Force .cursor/skills/lazy-code-skill, .cursor/skills/superpowers -ErrorAction SilentlyContinue
Copy-Item -Recurse .cursor/lazy-code-skill/.cursor/skills/lazy-code-skill .cursor/skills/
Copy-Item -Recurse .cursor/lazy-code-skill/.cursor/skills/superpowers .cursor/skills/
```

### 4. Copy rules (with prefix, force update)

Remove existing lazy-code-skill rules so only the latest rules from the repo remain; then copy each rule file with prefix `lazy-code-skill-`:

```bash
rm -f .cursor/rules/lazy-code-skill-*.mdc
for f in .cursor/lazy-code-skill/.cursor/rules/*.mdc; do
  [ -f "$f" ] && cp "$f" ".cursor/rules/lazy-code-skill-$(basename "$f")"
done
```

On Windows (PowerShell):

```powershell
Remove-Item .cursor/rules/lazy-code-skill-*.mdc -ErrorAction SilentlyContinue
Get-ChildItem .cursor/lazy-code-skill/.cursor/rules/*.mdc | ForEach-Object {
  Copy-Item $_.FullName ".cursor/rules/lazy-code-skill-$($_.Name)"
}
```

### 5. (Optional) Copy project_architecture.md template

Copy only if your project does not already have `.cursor/project_architecture.md` — if it exists, it is left unchanged.

```bash
[ -f .cursor/project_architecture.md ] || cp .cursor/lazy-code-skill/.cursor/project_architecture.md .cursor/project_architecture.md
```

On Windows (PowerShell):

```powershell
if (-not (Test-Path .cursor/project_architecture.md)) { Copy-Item .cursor/lazy-code-skill/.cursor/project_architecture.md .cursor/project_architecture.md }
```

### 6. Copy README (Basic Workflow reference)

Copy the lazy-code-skill README into `.cursor/` so you have the Basic Workflow and install reference without overwriting your project’s README:

```bash
cp .cursor/lazy-code-skill/README.md .cursor/lazy-code-skill-README.md
```

On Windows (PowerShell):

```powershell
Copy-Item .cursor/lazy-code-skill/README.md .cursor/lazy-code-skill-README.md
```

You can open `.cursor/lazy-code-skill-README.md` anytime for the Basic Workflow (brainstorming → writing-plans → TDD → etc.) and sync instructions.

### 7. Remove the cloned repo

After copying, remove the clone so only skills, rules, and the README copy remain. (`.cursor/plans/` and `.cursor/project_architecture.md` are never created or overwritten by this install if they already exist.)

```bash
rm -rf .cursor/lazy-code-skill
```

On Windows (PowerShell):

```powershell
Remove-Item -Recurse -Force .cursor/lazy-code-skill
```

## Usage

- **Skills** appear under Cursor Settings → Rules → Agent Decides. They can also be invoked manually in Agent chat with `/skill-name` (e.g. `/pre-commit-docs-sync`, `/dual-remote-push`).
- **Rules** are active for the project; Cursor loads them from `.cursor/rules/`.

## Updating

Re-run the same installation (steps 1–7) to **force update** your `.cursor/` to match the latest lazy-code-skill repo: clone again, then copy skills, rules, and README (overwriting existing). **`.cursor/plans/` and `.cursor/project_architecture.md` are never overwritten** — if they exist, they are left as-is.
