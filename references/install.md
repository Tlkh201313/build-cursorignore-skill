# Install

**Setup walkthrough:** [README.md](../README.md) · **Mistakes:** [troubleshooting.md](troubleshooting.md) · [Cursor Skills](https://cursor.com/docs/skills)

**Bundle:** `build-cursorignore` — copy **flat** to `~/.cursor/skills/build-cursorignore/SKILL.md` (not an extra nested folder inside skills). Invoke **`/build-cursorignore`**.

---

## Quick Install (Recommended)

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/install.ps1 | iex
```

### macOS / Linux (Bash)

```bash
curl -fsSL https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/install.sh | bash
```

---

## Manual Install

### Option 1: Git Clone

```bash
# Clone directly into Cursor skills directory
git clone --depth 1 https://github.com/Tlkh201313/build-cursorignore-skill ~/.cursor/skills/build-cursorignore
```

### Option 2: Download ZIP

1. Download: [main.zip](https://github.com/Tlkh201313/build-cursorignore-skill/archive/refs/heads/main.zip)
2. Extract to `~/.cursor/skills/build-cursorignore/`
3. Ensure `SKILL.md` is at the root of the folder

### Option 3: Copy from Cloned Repo

**Windows** (run from the cloned repo root):

```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\.cursor\skills\build-cursorignore" | Out-Null
Copy-Item -Recurse -Force * "$env:USERPROFILE\.cursor\skills\build-cursorignore\"
```

**macOS / Linux** (run from the cloned repo root):

```bash
mkdir -p ~/.cursor/skills/build-cursorignore
cp -R . ~/.cursor/skills/build-cursorignore/
```

---

## After Install

1. **Restart Cursor** — the skill won't appear until you restart
2. **Open your app repo** in Cursor **Agent** mode
3. **Type `/build-cursorignore`** and press Enter
4. **Follow the prompts** — scan, plan, approve, write

---

## Verify Installation

After restarting Cursor:

1. Open any repo in Cursor **Agent** mode
2. Type `/` in the chat
3. You should see **`build-cursorignore`** in the list

If it doesn't appear, see [troubleshooting.md](troubleshooting.md).

---

## Uninstall

### Quick Uninstall (Recommended)

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/uninstall.ps1 | iex
```

**macOS / Linux (Bash):**
```bash
curl -fsSL https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/uninstall.sh | bash
```

### Manual Uninstall

Delete the skill folder:

**Windows:**
```powershell
Remove-Item -Recurse -Force "$env:USERPROFILE\.cursor\skills\build-cursorignore"
```

**macOS / Linux:**
```bash
rm -rf ~/.cursor/skills/build-cursorignore
```

Restart Cursor after uninstalling.

---

## Project-Local Install (Optional)

Instead of installing globally, you can install in a specific repo:

```
your-repo/
  .cursor/skills/build-cursorignore/
    SKILL.md
    references/
    assets/
```

This only works when you open that specific repo in Cursor.

---

**Do not:** nest an extra folder (e.g. `.../skills/build-cursorignore/build-cursorignore-skill/SKILL.md`). Path must end with `.../build-cursorignore/SKILL.md`.
