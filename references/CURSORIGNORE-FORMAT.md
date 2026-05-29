# .cursorignore format

**Effect:** path is **fully blocked** — not indexed, cannot enter context, agent cannot open on request.

**Syntax:** gitignore (globs, trailing `/` for directories, `!` to re-include).

## Write order

1. Header comment: `# build-cursorignore` (or merge into existing file).
2. Marked block start: `# --- build-cursorignore ---`
3. Section comments: `# Dependencies`, `# Build output`, `# Cache`, etc.
4. Net-new patterns only (see [GITIGNORE-DEDUPE.md](GITIGNORE-DEDUPE.md)).
5. If media/binary globs used → **protection block** (below) before marked block end.
6. Marked block end: `# --- end build-cursorignore ---`

## Merge policy

- **Do not delete** user lines outside the marked block.
- Refresh **inside** the marked block on re-run; dedupe lines when merging.
- Baseline starter: [assets/cursorignore.baseline.template](../assets/cursorignore.baseline.template).

## Protection block (required after broad media/binary globs)

Append **below** globs like `*.png`, `*.pdf`:

```gitignore
# --- build-cursorignore: do not block editable source ---
!**/src/**
!**/app/**
!**/*.test.*
!**/*.spec.*
!**/.env.example
!**/README.md
!**/docs/**
!tailwind.config.*
!vite.config.*
!tsconfig.json
!next.config.*
```

Omit any `!` line that matches nothing in the repo. Add path-specific `!` as needed (e.g. `!app/**/*.png`).

Full catalog: [patterns-catalog.md](patterns-catalog.md).
