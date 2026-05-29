# Cursor notes

**Target:** the user’s **application repo** root — not this skill’s install/checkout.

**No writes on install.** Copying files to `~/.cursor/skills/build-cursorignore/` does not create `.cursorignore`. The user runs `/build-cursorignore` on an app repo when ready.

**Plan before write.** Phase 0–1 are read/plan only; Phase 2 runs only after the user says OK in chat.

**Invoke:** **`/build-cursorignore`** only (this bundle). Plain chat without the slash command does not load the skill workflow.

**Two ignore files** ([OVERVIEW.md](../OVERVIEW.md)):

| File | Effect |
|------|--------|
| `.cursorignore` | Fully blocked — agent cannot open even if asked |
| `.cursorindexingignore` | De-indexed — still openable on request |

Cursor already honors `.gitignore` — never duplicate those patterns ([GITIGNORE-DEDUPE.md](GITIGNORE-DEDUPE.md)).

After writes: user should **reindex** (Settings → Indexing → Resync) or restart Cursor, then start a **new Agent chat**.

Stack patterns: [annexes/INDEX.md](annexes/INDEX.md) · Detection: [stack-signals.md](stack-signals.md).

Docs: [Ignore files](https://cursor.com/docs/reference/ignore-file) · [Skills](https://cursor.com/docs/skills)

Human setup: [README.md](../README.md). Mistakes: [troubleshooting.md](troubleshooting.md).
