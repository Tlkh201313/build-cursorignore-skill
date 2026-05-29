# Ignore checklist

Agent workflow for **`/build-cursorignore`**. Run on the **target app repo** — never on this skill’s source/install tree unless the user explicitly asks to dogfood.

## Single phase — Scan, write, report

- [ ] Confirm workspace is the user's **application** repo (not a tree that is only `SKILL.md` + `references/` + `assets/`).
- [ ] If this is the skill bundle checkout → tell user to open their app repo and run the skill there later.
- [ ] List top-level files and folders.
- [ ] Read `.gitignore` if present; build skip-list per [GITIGNORE-DEDUPE.md](GITIGNORE-DEDUPE.md).
- [ ] Detect stacks per [stack-signals.md](stack-signals.md); note matching [annexes/INDEX.md](annexes/INDEX.md) entries.
- [ ] Note existing `.cursorignore` / `.cursorindexingignore` (for merge plan only).
- [ ] List net-new patterns for `.cursorignore` (universal + conditional + stack annexes).
- [ ] List net-new patterns for `.cursorindexingignore`.
- [ ] Flag any broad media/binary globs → plan protection block per [CURSORIGNORE-FORMAT.md](CURSORIGNORE-FORMAT.md).
- [ ] Skip anything already in `.gitignore` or not present on disk.
- [ ] Assign each pattern to an importance tier per [importance-tiers.md](importance-tiers.md) (T1-T5).
- [ ] **SQL rule:** migration globs only per [patterns-catalog.md](patterns-catalog.md) — not for SQL-first repos.
- [ ] Write or merge `.cursorignore` per [CURSORIGNORE-FORMAT.md](CURSORIGNORE-FORMAT.md).
- [ ] Write or merge `.cursorindexingignore` per [CURSORINDEXINGIGNORE-FORMAT.md](CURSORINDEXINGIGNORE-FORMAT.md).
- [ ] Use marked section `# --- build-cursorignore ---` when updating existing files.
- [ ] Reply using [examples/report-example.md](examples/report-example.md).
- [ ] Remind: reindex or restart Cursor; new Agent chat recommended.
