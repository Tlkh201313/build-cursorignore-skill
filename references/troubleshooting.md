# Troubleshooting

Pick **one section** below that matches what went wrong.

**Quick checks**

| Check | What to do |
|-------|------------|
| Command | Type **`/build-cursorignore`** in **Cursor Agent** on your **app repo**, not this skill’s source tree |
| Install folder | `~/.cursor/skills/build-cursorignore/SKILL.md` must exist — [install.md](install.md) |
| Catalog | `~/.cursor/skills/build-cursorignore/references/patterns-catalog.md` must exist (full flat copy) |
| After install | Restart Cursor so `/` shows **build-cursorignore** |

Plain chat without `/build-cursorignore` does **not** run the skill.

---

## `/build-cursorignore` does not show up

| Cause | Fix |
|-------|-----|
| Not installed yet | Flat copy into `~/.cursor/skills/build-cursorignore/` — [install.md](install.md) |
| Wrong folder name | Folder must be **`build-cursorignore`** (matches `name:` in frontmatter) |
| Extra nested folder | Path must end with `.../build-cursorignore/SKILL.md` |
| Cursor not refreshed | Quit and restart Cursor |
| Opened skill source tree | Install globally, open **your project** repo |
| Wrong chat mode | Use **Agent** chat |

---

## The agent "can't see" a file

| Symptom | Fix |
|---------|-----|
| File fully invisible | Pattern is in **`.cursorignore`** — move to **`.cursorindexingignore`** or remove |
| Need file back | Delete pattern, or add `!` **below** the broad rule — [CURSORIGNORE-FORMAT.md](CURSORIGNORE-FORMAT.md) |
| Lock file blocked | Lock files belong in `.cursorindexingignore`, not `.cursorignore` |

---

## Changes don't take effect

- Reindex: Settings → Indexing → Resync, or restart Cursor.
- Start a **new Agent chat** after writing ignore files.

---

## Duplicate patterns from `.gitignore`

Should not happen if [GITIGNORE-DEDUPE.md](GITIGNORE-DEDUPE.md) was followed. Delete duplicate lines from `.cursorignore`. `/dist` vs `dist/` are equivalent — safe to remove one.

---

## Something under `src/` or a config was hidden

Delete the offending pattern; add `!` re-include per [CURSORIGNORE-FORMAT.md](CURSORIGNORE-FORMAT.md). File a bug if a default pattern did this without a broad glob.

---

## Ran the skill on the wrong repo

If you ran `/build-cursorignore` on this skill’s GitHub checkout by mistake, revert `.cursorignore` / `.cursorindexingignore` or restore from git. The skill targets **your application repo**.

---

## Indexing and ignore files

`.cursorindexingignore` and `.cursorignore` affect Cursor indexing and context — **not** full security (terminals may still read paths). [Official docs](https://cursor.com/docs/reference/ignore-file).

**Running again:** Safe to re-run; refresh the `# --- build-cursorignore ---` marked block instead of duplicating lines. Duplicates usually mean markers were removed or paths were copied by hand.

---

## Still stuck

1. [install.md](install.md)
2. [README.md](../README.md)

Then in Agent on **your repo**: `/build-cursorignore` and say *"Confirm this folder before writing files."*
