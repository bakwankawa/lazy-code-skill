# Installing lazy-code-skill for Cursor

Quick setup to enable lazy-code-skill rules and skills in Cursor at **project level**.

> **Important:** Cursor does not discover symlinked rules or skills. This installation uses copy-based setup. The cloned repo is removed after copy (step 6). To update, re-run the full installation (see Updating).

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

### 3. Copy skills

```bash
rm -rf .cursor/skills/lazy-code-skill
cp -r .cursor/lazy-code-skill/.cursor/skills .cursor/skills/lazy-code-skill
```

### 4. Copy rules (with prefix)

Copy each rule file with prefix `lazy-code-skill-` so existing project rules are not overwritten:

```bash
for f in .cursor/lazy-code-skill/.cursor/rules/*.mdc; do
  [ -f "$f" ] && cp "$f" ".cursor/rules/lazy-code-skill-$(basename "$f")"
done
```

On Windows (PowerShell), you can run:

```powershell
Get-ChildItem .cursor/lazy-code-skill/.cursor/rules/*.mdc | ForEach-Object {
  Copy-Item $_.FullName ".cursor/rules/lazy-code-skill-$($_.Name)"
}
```

### 5. (Optional) Copy project_architecture.md template

Copy only if your project does not already have `.cursor/project_architecture.md`:

```bash
[ -f .cursor/project_architecture.md ] || cp .cursor/lazy-code-skill/.cursor/project_architecture.md .cursor/project_architecture.md
```

### 6. Remove the cloned repo

After copying, remove the clone so only skills and rules remain in your project:

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

The clone is removed after install, so to get the latest skills and rules **re-run the full installation** (steps 1–6): clone again, copy skills and rules, then remove the clone again.
