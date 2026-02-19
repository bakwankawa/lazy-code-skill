# Installing lazy-code-skill for Claude

Quick setup to enable lazy-code-skill rules and skills in Claude at **project level**.

> **Important:** Claude does not discover symlinked rules or skills. This installation uses copy-based setup. The cloned repo is removed after copy (step 7). To update, re-run the full installation (see Updating).
>
> **Re-run = force update:** Running the install again overwrites skills, rules, and the README copy so your `.claude/` matches the latest lazy-code-skill repo. **`.claude/plans/` and `.claude/project_architecture.md` are never overwritten** — if they exist, their contents are left unchanged.
>
> **Safe update guarantee:** This process does **not** delete other folders in `.claude/`. It only modifies:
> - `.claude/skills/*` (all skills)
> - `.claude/rules/lazy-code-skill-*.mdc`
> - `.claude/lazy-code-skill-README.md`
> - Temporary clone folder `.claude/lazy-code-skill` (removed at the end)
>
> Other paths like `.claude/conversations/`, `.claude/docs/`, `.claude/plans/`, `.claude/reviews/`, `.claude/test/`, and any custom folders are preserved.

## Installation (project-level)

Run this command from your **project root** (the directory that will contain `.claude/`).

### Recommended: run the install script

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/bakwankawa/lazy-code-skill/refs/heads/main/.claude/scripts/install.sh)
```

The script handles all steps automatically and **verifies the result**: it confirms that each skill was installed as a directory (e.g. `.claude/skills/systematic-debugging/`) — not as flat `.md` files. If verification fails, it exits with an error and tells you to re-run.

> **Expected result:** After install, `.claude/skills/` must contain **directories** (one per skill), not individual `.md` files.
> Run `ls .claude/skills/` to confirm — you should see names like `systematic-debugging`, `brainstorming`, `test-driven-development`, etc.
> If you see flat `.md` files instead, the install did not complete correctly. Re-run the script above.

---

## Manual installation (fallback)

If you cannot use `curl`, run these commands step-by-step from your **project root**.

> **Agent note:** Each skill is a **directory** containing `SKILL.md` and supporting files.
> The copy command below preserves this directory structure. Do NOT recursively collect `.md` files flat — that will break skill discovery.

### 1. Clone the repository

```bash
mkdir -p .claude
git clone https://github.com/bakwankawa/lazy-code-skill.git .claude/lazy-code-skill
```

Use branch `main`; if your clone defaults to another branch, run `git -C .claude/lazy-code-skill checkout main` after cloning.

### 2. Create directories

```bash
mkdir -p .claude/skills .claude/rules
```

### 3. Copy skills (each skill as a directory)

```bash
rm -rf .claude/skills/*
for skill_dir in .claude/lazy-code-skill/.claude/skills/*/; do
  [ -d "$skill_dir" ] || continue
  cp -r "$skill_dir" .claude/skills/
done
```

> **Important:** The loop above copies only directories (one per skill). After this step,
> `ls .claude/skills/` must show directory names like `systematic-debugging`, `brainstorming`, etc.
> If it shows `.md` files, something went wrong — do not proceed; re-run from step 1.

On Windows (PowerShell):

```powershell
Remove-Item -Recurse -Force .claude/skills/* -ErrorAction SilentlyContinue
Get-ChildItem -Path .claude/lazy-code-skill/.claude/skills -Directory | Copy-Item -Destination .claude/skills/ -Recurse -Force
```

### 4. Copy rules (with prefix, force update)

Remove existing lazy-code-skill rules so only the latest rules from the repo remain; then copy each rule file with prefix `lazy-code-skill-`:

```bash
rm -f .claude/rules/lazy-code-skill-*.mdc
for f in .claude/lazy-code-skill/.claude/rules/*.mdc; do
  [ -f "$f" ] && cp "$f" ".claude/rules/lazy-code-skill-$(basename "$f")"
done
```

On Windows (PowerShell):

```powershell
Remove-Item .claude/rules/lazy-code-skill-*.mdc -ErrorAction SilentlyContinue
Get-ChildItem .claude/lazy-code-skill/.claude/rules/*.mdc | ForEach-Object {
  Copy-Item $_.FullName ".claude/rules/lazy-code-skill-$($_.Name)"
}
```

### 5. (Optional) Copy project_architecture.md template

Copy only if your project does not already have `.claude/project_architecture.md` — if it exists, it is left unchanged.

```bash
[ -f .claude/project_architecture.md ] || cp .claude/lazy-code-skill/.claude/project_architecture.md .claude/project_architecture.md
```

On Windows (PowerShell):

```powershell
if (-not (Test-Path .claude/project_architecture.md)) { Copy-Item .claude/lazy-code-skill/.claude/project_architecture.md .claude/project_architecture.md }
```

### 6. Copy README (Basic Workflow reference)

Copy the lazy-code-skill README into `.claude/` so you have the Basic Workflow and install reference without overwriting your project's README:

```bash
cp .claude/lazy-code-skill/README.md .claude/lazy-code-skill-README.md
```

On Windows (PowerShell):

```powershell
Copy-Item .claude/lazy-code-skill/README.md .claude/lazy-code-skill-README.md
```

You can open `.claude/lazy-code-skill-README.md` anytime for the Basic Workflow (brainstorming → writing-plans → TDD → etc.) and sync instructions.

### 7. Remove the cloned repo

After copying, remove the clone so only skills, rules, and the README copy remain. (`.claude/plans/` and `.claude/project_architecture.md` are never created or overwritten by this install if they already exist.)

```bash
rm -rf .claude/lazy-code-skill
```

On Windows (PowerShell):

```powershell
Remove-Item -Recurse -Force .claude/lazy-code-skill
```

### 8. Verify

```bash
ls .claude/skills/
```

You must see **directory names** (e.g. `systematic-debugging`, `brainstorming`, `test-driven-development`), not individual `.md` files. If you see flat `.md` files, re-run from step 1.

---

## Usage

- **Skills** appear under Claude Settings → Rules → Agent Decides. They can also be invoked manually in Agent chat with `/skill-name` (e.g. `/pre-commit-docs-sync`, `/dual-remote-push`).
- **Rules** are active for the project; Claude loads them from `.claude/rules/`.

## Updating

Re-run the install script to **force update** your `.claude/` to match the latest lazy-code-skill repo. **Only the paths listed in "Safe update guarantee" are touched.** Other `.claude/` folders stay unchanged.

## Updating upstream skills (maintainers of this repo only)

In the **lazy-code-skill repo**, run:

```bash
bash .claude/scripts/sync-all-upstreams.sh
```

This syncs skills from all upstream sources (Superpowers, Anthropic, Vercel Labs) directly into `.claude/skills/`. Then review and commit. Downstream projects that install this repo do not run this script; they receive the already-synced copy when they install or update.
