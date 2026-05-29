---
name: build-cursorignore
description: Scans the current project and writes .cursorignore and .cursorindexingignore files tuned to the stack — fully blocking dead weight (dependencies, build output, caches, binaries) and de-indexing rarely-needed files (lock files, generated code, snapshots) without hiding source the developer edits. Use when Cursor is reading too many files, consuming too many tokens, or when the user asks to reduce context size or ignore junk files.
---

# Build .cursorignore

Run on the **target app repo** — never on this skill's source tree.

## Single phase — scan, write, report

1. **Scan** — list top-level files/folders, read `.gitignore` to build skip-list
2. **Write** — create `.cursorignore` and `.cursorindexingignore` with matching patterns
3. **Report** — show what was blocked and top token savings

## Two files

| File | Effect |
|------|--------|
| `.cursorignore` | Fully blocked — agent cannot open |
| `.cursorindexingignore` | De-indexed — still openable on request |

- Cursor already honors `.gitignore` — never duplicate those patterns
- When unsure, prefer `.cursorindexingignore` over `.cursorignore`
- Nothing under `src/`, `app/`, tests, or configs gets hidden

## Patterns (apply only if files exist)

### Always `.cursorignore`
- `node_modules/`, `.pnpm-store/`, `.venv/`, `vendor/`, `__pycache__/`
- `dist/`, `build/`, `out/`, `.next/`, `.nuxt/`, `target/`
- `.cache/`, `.turbo/`, `.nx/`, `.eslintcache`
- `*.log`, `logs/`, `*.tmp`
- `*.exe`, `*.dll`, `*.so`, `*.dylib`, `*.wasm`
- `*.png`, `*.jpg`, `*.pdf`, `*.zip`, `*.map`, `*.min.js`, `*.min.css`

### Always `.cursorindexingignore`
- `*.lock`, `*.lockb` (lock files)
- `*.snap`, `__snapshots__/` (test snapshots)
- `*.generated.*`, `*.d.ts` (generated code)
- `migrations/`, `prisma/migrations/` (database migrations)

### Conditional (detect stack first)
- `.yarn/cache/`, `.yarn/install-state.gz` (Yarn Berry)
- `.bun/`, `bun.lockb` (Bun)
- `.deno/`, `deno.lock` (Deno)
- `.terraform/`, `*.tfstate` (Terraform)
- `.gradle/`, `*.jar` (JVM)
- `bin/`, `obj/`, `*.nupkg` (.NET)
- `vendor/bundle/` (Ruby)
- `.dart_tool/` (Flutter)
- `android/.gradle/`, `ios/build/`, `DerivedData/`, `Pods/` (Mobile)

## Write format

Both files use gitignore syntax. Mark skill sections:
```
# --- build-cursorignore ---
<patterns>
# --- /build-cursorignore ---
```

Add `!` re-includes for protected paths:
```
!src/
!app/
!*.test.*
!*.config.*
```

## Report format

```
.cursorignore — X new patterns
.cursorindexingignore — Y new patterns
Top savings: [list 3 heaviest paths]
Restart Cursor to apply.
```
