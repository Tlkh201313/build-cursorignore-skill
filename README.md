# Build .cursorignore Skill

Your agent is drowning in junk.

It opens `node_modules`. It indexes a 4 MB lock file. It reads a minified bundle, a coverage report, a folder of PNGs — and burns thousands of tokens doing it. Every one of those tokens was supposed to go toward understanding *your* code. Instead it went to dead weight.

You can fix this by hand. Most people don't, because Cursor's two ignore files have a subtle split — `.cursorignore` makes a file **completely invisible to the agent**, while `.cursorindexingignore` only **de-indexes** it (the agent can still open it on request). Get that wrong and you either waste context or hide the one file you needed.

**Build .cursorignore** does it for you. One command scans your repo, reads your existing `.gitignore` so it never writes a redundant line, sorts the noise into the right ignore file, and protects the things you actually edit. [Install](references/install.md) the skill to `~/.cursor/skills/build-cursorignore/`, open your repo in Cursor Agent, and run **`/build-cursorignore`**.

---

## Your code stays reachable

The skill is **conservative by default**. Dependencies, build output, and binaries go in `.cursorignore`. Lock files, generated code, migrations, and snapshots go in `.cursorindexingignore` so they leave the index but stay one request away.

Nothing important gets hidden. Test files, configs you edit, `.env.example`, source markdown, and everything under `src/`/`app/` are protected — broad globs get `!` re-includes per [CURSORIGNORE-FORMAT.md](references/CURSORIGNORE-FORMAT.md).

It reads your `.gitignore` first and **skips every pattern already covered there**.

---

## What it writes

| Output | What it is |
|--------|------------|
| **`.cursorignore`** | Dead weight: dependencies, build output, caches, binaries, logs — fully hidden from the agent |
| **`.cursorindexingignore`** | Rarely-needed: lock files, generated code, snapshots, migrations — de-indexed, still readable |
| **Report (chat)** | Net-new paths blocked, what moved where, and the 3 heaviest token wins |

Details: [OVERVIEW.md](OVERVIEW.md) · [SKILL.md](SKILL.md)

---

## Quick start

**Install the skill (no ignore files yet)**

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/install.ps1 | iex
```

**macOS / Linux (Bash):**
```bash
curl -fsSL https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/install.sh | bash
```

Or [manual install](references/install.md) — flat copy to `~/.cursor/skills/build-cursorignore/`

**Then restart Cursor**

**Generate ignore files later (on your app repo)**

3. Open **your app** repo root in Cursor **Agent**
4. `/build-cursorignore` — scan + plan in chat, then write after you say OK
5. Reindex when prompted, or restart Cursor

Do not run `/build-cursorignore` on this skill’s source repo unless you are dogfooding on purpose.

Plain English does not load this skill. New to Cursor Agent? [Quickstart](https://cursor.com/docs/get-started/quickstart).

**Check:** nothing under `src/`/`app/` was hidden; lock files in `.cursorindexingignore` (not `.cursorignore`); no `.gitignore` duplicates — [troubleshooting.md](references/troubleshooting.md)

---

## Uninstall

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/uninstall.ps1 | iex
```

**macOS / Linux (Bash):**
```bash
curl -fsSL https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/uninstall.sh | bash
```

Or manually delete `~/.cursor/skills/build-cursorignore/` and restart Cursor.

---

## License

MIT — [LICENSE](LICENSE)
