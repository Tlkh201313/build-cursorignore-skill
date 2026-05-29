---
name: build-cursorignore
description: Scans the current project and writes .cursorignore and .cursorindexingignore files tuned to the stack — fully blocking dead weight (dependencies, build output, caches, binaries) and de-indexing rarely-needed files (lock files, generated code, snapshots) without hiding source the developer edits. Use when Cursor is reading too many files, consuming too many tokens, or when the user asks to reduce context size or ignore junk files.
---

# Build .cursorignore

**Install this bundle does not write ignore files.** Copying the skill to `~/.cursor/skills/build-cursorignore/` is setup only. Ignore files are created **later**, when the user runs `/build-cursorignore` on their **app repo**.

Follow [references/ignore-checklist.md](references/ignore-checklist.md):

1. **Single phase:** scan repo, write files, show report — all in one go.

Never write ignore files into this skill’s source tree (`SKILL.md` + `references/` + `assets/` at repo root).

## Authority (read in order)

| Step | Document |
|------|----------|
| Workflow | [references/ignore-checklist.md](references/ignore-checklist.md) |
| Cursor-specific | [references/cursor-notes.md](references/cursor-notes.md) |
| Detect stack | [references/stack-signals.md](references/stack-signals.md) → [references/annexes/INDEX.md](references/annexes/INDEX.md) |
| Universal patterns | [references/patterns-catalog.md](references/patterns-catalog.md) |
| Skip `.gitignore` dupes | [references/GITIGNORE-DEDUPE.md](references/GITIGNORE-DEDUPE.md) |
| Write `.cursorignore` | [references/CURSORIGNORE-FORMAT.md](references/CURSORIGNORE-FORMAT.md) (Phase 2 only) |
| Write `.cursorindexingignore` | [references/CURSORINDEXINGIGNORE-FORMAT.md](references/CURSORINDEXINGIGNORE-FORMAT.md) (Phase 2 only) |
| Chat closeout | [references/examples/report-example.md](references/examples/report-example.md) |
| File importance | [references/importance-tiers.md](references/importance-tiers.md) |

Load paths: `references/…` next to this skill, or `~/.cursor/skills/build-cursorignore/references/…`.

Templates (reference only until Phase 2): [assets/cursorignore.baseline.template](assets/cursorignore.baseline.template), [assets/cursorindexingignore.baseline.template](assets/cursorindexingignore.baseline.template).

## Two files (summary)

| File | Effect |
|------|--------|
| `.cursorignore` | Fully blocked — agent cannot open even if asked |
| `.cursorindexingignore` | De-indexed — still openable on request |

- Cursor already honors `.gitignore` — never duplicate those patterns.
- When unsure, prefer `.cursorindexingignore` over `.cursorignore`.

Human overview: [OVERVIEW.md](OVERVIEW.md) · Install: [references/install.md](references/install.md).
