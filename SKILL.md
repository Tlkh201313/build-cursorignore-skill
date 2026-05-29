---
name: build-cursorignore
description: Scans the current repo and writes .cursorignore and .cursorindexingignore tuned to the detected stack — blocking dead weight (deps, build output, caches, binaries) and de-indexing low-value files (locks, generated code, snapshots) without touching editable source. Trigger when Cursor reads too many files, burns tokens on junk, or the user asks to reduce context size or ignore noise.
---
# Build .cursorignore

Run on the **target app repo** — never on this skill's own files.

## Phase 1 — Scan

### 1a. Directory inventory
List all top-level dirs and files. Note:
- Source roots present: `src/`, `app/`, `lib/`, `packages/`, `apps/`
- Monorepo? (`packages/` or `apps/` with multiple `package.json` / workspace manifests) — if yes, repeat stack detection inside each workspace root

### 1b. Read existing ignores
- Capture all `.gitignore` patterns — **never duplicate** them
- Check whether `.cursorignore` / `.cursorindexingignore` already exist:
  - Has `# --- build-cursorignore ---` block → **merge** (replace that block only)
  - Exists without block → **append** new block at end
  - Does not exist → **create**

### 1c. Detect stack
Check for these indicator files at the repo root (and each workspace package in a monorepo):

| Indicator present | Stack |
|---|---|
| `package.json` | Node.js |
| `yarn.lock` (no `.yarn/` dir) | Yarn Classic |
| `.yarn/` dir | Yarn Berry |
| `bun.lockb` | Bun |
| `deno.json` or `deno.lock` | Deno |
| `requirements.txt`, `pyproject.toml`, or `setup.py` | Python |
| `Cargo.toml` | Rust |
| `go.mod` | Go |
| `Gemfile` | Ruby |
| `build.gradle`, `pom.xml`, or `*.gradle.kts` | JVM (Gradle / Maven) |
| `*.csproj`, `*.sln`, or `global.json` | .NET |
| `pubspec.yaml` | Flutter / Dart |
| `*.tf` or `.terraform/` dir | Terraform |
| `android/` dir | Android / React Native |
| `ios/` dir or `Podfile` | iOS / React Native |
| `CMakeLists.txt` | CMake / C++ |
| `mix.exs` | Elixir |
| `stack.yaml` | Haskell |

---

## Phase 2 — Write

### `.cursorignore` — agent cannot open these files

#### Always add (only if the path actually exists on disk)

**Dependencies**
```
node_modules/
.pnpm-store/
.venv/
venv/
__pycache__/
*.pyc
*.pyo
```

**Build output**
```
dist/
build/
out/
.next/
.nuxt/
.svelte-kit/
target/
storybook-static/
.docusaurus/
```

**Caches**
```
.cache/
.turbo/
.nx/
.parcel-cache/
.eslintcache
.stylelintcache
*.tsbuildinfo
```

**Test coverage and output**
```
coverage/
.nyc_output/
.c8/
.pytest_cache/
.mypy_cache/
.ruff_cache/
htmlcov/
playwright-report/
test-results/
```

**Logs and temp**
```
*.log
logs/
*.tmp
*.temp
```

**Compiled / binary**
```
*.exe
*.dll
*.so
*.dylib
*.wasm
*.class
*.o
*.a
```

**Large static assets**
⚠ Do NOT add `*.svg` globally — it may be React/Vue source components. Use `public/**/*.svg` instead if the project has a `public/` asset dir.
```
*.png
*.jpg
*.jpeg
*.gif
*.ico
*.webp
*.pdf
*.mp4
*.webm
*.mp3
*.zip
*.tar.gz
public/**/*.svg
```

**Generated web assets**
```
*.map
*.min.js
*.min.css
```

**OS noise**
```
.DS_Store
Thumbs.db
```

#### Conditional — add only for detected stacks

| Stack | Patterns to add |
|---|---|
| Yarn Berry | `.yarn/cache/` `.yarn/install-state.gz` |
| Bun | `.bun/` |
| Deno | `.deno/` |
| Python | `.eggs/` `*.egg-info/` |
| Rust | `.cargo/registry/` `.cargo/git/` |
| Go | `vendor/` (only when `go.sum` is also present) |
| JVM / Gradle | `.gradle/` `*.jar` `*.war` `*.ear` |
| JVM / Maven | `.m2/` `*.jar` |
| .NET | `obj/` `*.nupkg` — **only add `bin/` if a `.csproj`/`.sln` is present**; `bin/` is a common scripts directory in non-.NET projects |
| Ruby | `vendor/bundle/` `.bundle/` |
| Flutter | `.dart_tool/` `*.g.dart` `*.freezed.dart` |
| Android | `android/.gradle/` `android/build/` |
| iOS | `ios/build/` `DerivedData/` `Pods/` |
| Terraform | `.terraform/` `*.tfstate` `*.tfstate.backup` |
| Elixir | `_build/` `deps/` |
| CMake / C++ | `cmake-build-*/` `_deps/` `.ccache/` |
| Haskell | `.stack-work/` |

#### Protected re-includes
Append these after all blocking patterns. They guard common source directories from accidental silencing by earlier globs:
```
!src/
!app/
!lib/
!packages/
!apps/
!components/
!pages/
!routes/
!api/
!hooks/
!store/
!models/
!controllers/
!services/
!tests/
!__tests__/
!spec/
!*.config.*
!*.test.*
!*.spec.*
```

---

### `.cursorindexingignore` — de-indexed but still openable on request

#### Always add (only if the path actually exists on disk)

**Lock files**
```
package-lock.json
yarn.lock
*.lock
*.lockb
```

**Test snapshots**
```
*.snap
__snapshots__/
```

**Generated code**
```
*.generated.*
*.pb.go
*.pb.js
*.pb.ts
_generated/
generated/
```

**Type declaration outputs**
⚠ Only add `*.d.ts` if the project compiles TypeScript to a separate output dir. If hand-authored `.d.ts` files live under `src/` or `types/`, use `dist/**/*.d.ts` instead.
```
*.d.ts
```

**DB migrations**
⚠ Only add if migrations are auto-generated (e.g. Prisma, Alembic auto-generate). Skip if migrations are hand-authored — they are useful context for schema understanding.
```
migrations/
prisma/migrations/
```

#### Conditional

| Stack | Patterns | Note |
|---|---|---|
| Any | `CHANGELOG.md` | Only if auto-generated (check for repeating `## [x.y.z]` release headers) |
| JVM | `*.iml` `*.ipr` | IDE project files |
| Python | `requirements*.txt` | Only if output of `pip-compile` / `uv pip compile`, not hand-authored |

---

### Write format
Both files use gitignore syntax. Wrap all managed patterns in skill fences:
```
# --- build-cursorignore ---
<patterns>

<protected re-includes>
# --- /build-cursorignore ---
```

---

## Phase 3 — Validate

Before writing, check for foot-guns:

- **No bare extension globs on text formats.** `*.ts`, `*.py`, `*.go` would silently nuke all source. Use path-qualified forms (`dist/**/*.js`) if an extension must be scoped.
- **No pattern matches detected source roots** (`src/`, `app/`, `lib/`, `packages/`, `apps/`).
- **`*.svg` not added globally** if project has `.jsx`/`.tsx`/`.vue` files.
- **`bin/`** only added for confirmed .NET projects (see above).
- **`*.d.ts`** — verify placement (global vs `dist/**`) based on project layout.
- **Migrations** — confirm they are auto-generated before silencing.

For each skipped pattern, record the pattern and reason for the report.

---

## Phase 4 — Report

```
.cursorignore         — X new patterns  (+Y re-includes)
.cursorindexingignore — Z new patterns

Top savings (estimated):
  node_modules/    ~XXX MB
  .next/ or dist/  ~XX MB
  coverage/        ~X MB

⚠ Skipped: [pattern] — [reason]
Restart Cursor to apply changes.
```
