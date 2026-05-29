# Build .cursorignore — overview

Cursor indexes your repo and pulls files into context. `.gitignore` is tuned for version control, not for what an AI should read — so agents waste tokens on lock files, build output, and binary assets.

**This bundle (v1):** markdown workflow · **`/build-cursorignore`** · install [`references/install.md`](references/install.md) · layout aligned with [cursor-landing-v3](https://github.com/rphoward/cursor-landing-v3).

Not [Cursor’s IDE quickstart](https://cursor.com/docs/get-started/quickstart) — this skill writes ignore files in **your app repo**.

## What you get

| Output | Role |
|--------|------|
| `.cursorignore` | Fully block dead weight (deps, build, caches, binaries) |
| `.cursorindexingignore` | De-index rarely-needed files (locks, generated code, snapshots) |
| Report (chat) | Net-new paths, top token wins, reindex reminder |

The two-file split: [README.md](README.md). Workflow: [SKILL.md](SKILL.md). Issues: [troubleshooting.md](references/troubleshooting.md).

## Design principles

- **Conservative beats aggressive** — when unsure, use `.cursorindexingignore`.
- **Only add what exists** — no speculative stack patterns.
- **Never duplicate `.gitignore`** — see [GITIGNORE-DEDUPE.md](references/GITIGNORE-DEDUPE.md).
- **Protect editable source** — `src/`, `app/`, tests, configs; see [CURSORIGNORE-FORMAT.md](references/CURSORIGNORE-FORMAT.md).
