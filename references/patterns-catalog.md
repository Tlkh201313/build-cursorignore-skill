# Patterns catalog

Exhaustive pattern list for **build-cursorignore**. Each pattern has a **target file**:

| Target | Meaning |
|--------|---------|
| `cursorignore` | `.cursorignore` — fully blocked |
| `indexing` | `.cursorindexingignore` — de-indexed, still openable |

## Rules (apply to every pattern)

1. **Skip** if the path does not exist in the repo (no speculative patterns).
2. **Skip** if `.gitignore` already covers it (Cursor honors `.gitignore`; duplicates are noise).
3. **When unsure**, use `indexing`, not `cursorignore`.
4. After writing broad globs, append the **protection block** from [CURSORIGNORE-FORMAT.md](CURSORIGNORE-FORMAT.md) with `!` lines.
5. Stack-specific patterns: [annexes/INDEX.md](annexes/INDEX.md) (detect via [stack-signals.md](stack-signals.md)).

Normalize `.gitignore` entries before comparing: strip leading `/`, treat `dist` and `dist/` as equivalent, ignore comment-only lines.

---

## Universal — dependencies

| Pattern | Target | Notes |
|---------|--------|-------|
| `node_modules/` | cursorignore | Node / JS |
| `.pnpm-store/` | cursorignore | pnpm global store (if in repo) |
| `.venv/` | cursorignore | Python |
| `venv/` | cursorignore | Python |
| `env/` | cursorignore | Python virtualenv (only if not app source named `env/`) |
| `__pycache__/` | cursorignore | Python |
| `*.py[cod]` | cursorignore | Python bytecode |
| `vendor/` | cursorignore | PHP / Go modules vendored |
| `.bundle/` | cursorignore | Ruby |
| `.gradle/` | cursorignore | Gradle cache in tree |
| `Pods/` | cursorignore | CocoaPods |
| `Carthage/Build/` | cursorignore | iOS |
| `.cargo/registry/` | cursorignore | Rare in repo; skip if absent |
| `.yarn/cache/` | cursorignore | Yarn Berry cache (can be huge) |
| `.yarn/install-state.gz` | cursorignore | Yarn Berry install state |
| `.yarn/unplugged/` | cursorignore | Yarn Berry unplugged packages |

---

## Universal — build output

| Pattern | Target | Notes |
|---------|--------|-------|
| `dist/` | cursorignore | |
| `build/` | cursorignore | Skip if repo root is literally a `build/` package you edit |
| `out/` | cursorignore | Next.js export / generic |
| `.next/` | cursorignore | Next.js |
| `.nuxt/` | cursorignore | Nuxt |
| `.output/` | cursorignore | Nitro |
| `.svelte-kit/` | cursorignore | SvelteKit |
| `target/` | cursorignore | Rust / Java (Maven) — confirm stack |
| `bin/` | cursorignore | Only if generated binaries, not hand-written `bin/` scripts |
| `obj/` | cursorignore | .NET |
| `*.exe` | cursorignore | Windows binaries |
| `*.dll` | cursorignore | |
| `*.so` | cursorignore | |
| `*.dylib` | cursorignore | |
| `*.pyc` | cursorignore | |
| `*.class` | cursorignore | |
| `*.jar` | cursorignore | Unless only source is `.java` and jars are not in tree |
| `storybook-static/` | cursorignore | If folder exists |

---

## Universal — caches

| Pattern | Target | Notes |
|---------|--------|-------|
| `.cache/` | cursorignore | |
| `.parcel-cache/` | cursorignore | |
| `.turbo/` | cursorignore | Turborepo |
| `.bun/` | cursorignore | Bun cache |
| `.nx/` | cursorignore | Nx cache |
| `.eslintcache` | cursorignore | |
| `*.tsbuildinfo` | cursorignore | TypeScript |
| `.mypy_cache/` | cursorignore | |
| `.pytest_cache/` | cursorignore | |
| `.ruff_cache/` | cursorignore | |
| `.tox/` | cursorignore | |
| `.nox/` | cursorignore | |
| `.hypothesis/` | cursorignore | |
| `.sass-cache/` | cursorignore | |
| `.webpack/` | cursorignore | |
| `.vite/` | cursorignore | Only if cache dir exists (not `vite.config`) |
| `.nyc_output/` | cursorignore | |
| `htmlcov/` | cursorignore | |
| `coverage/` | cursorignore | |
| `.coverage` | cursorignore | |
| `*.cover` | cursorignore | |
| `.idea/` | cursorignore | JetBrains |
| `.DS_Store` | cursorignore | |
| `Thumbs.db` | cursorignore | |
| `.changeset/` | indexing | Changesets versioning (contains changelogs) |

---

## Universal — logs & temp

| Pattern | Target | Notes |
|---------|--------|-------|
| `*.log` | cursorignore | |
| `logs/` | cursorignore | |
| `npm-debug.log*` | cursorignore | |
| `yarn-debug.log*` | cursorignore | |
| `yarn-error.log*` | cursorignore | |
| `pnpm-debug.log*` | cursorignore | |
| `*.tmp` | cursorignore | |
| `*.temp` | cursorignore | |
| `tmp/` | cursorignore | If temp dir, not app `tmp` package |
| `temp/` | cursorignore | |

---

## Universal — Docker & CI/CD

| Pattern | Target | Notes |
|---------|--------|-------|
| `.docker/` | cursorignore | Docker build context |
| `docker-compose.override.yml` | indexing | Local overrides |
| `.github/.cache/` | cursorignore | GitHub Actions cache |
| `artifacts/` | cursorignore | CI artifacts (if not source) |
| `test-results/` | cursorignore | CI test results |

---

## Universal — media & binaries

Use only when those file types exist outside `src/` / `app/`. Always append the **protection block** after these lines.

| Pattern | Target | Notes |
|---------|--------|-------|
| `*.png` | cursorignore | |
| `*.jpg` | cursorignore | |
| `*.jpeg` | cursorignore | |
| `*.gif` | cursorignore | |
| `*.ico` | cursorignore | |
| `*.webp` | cursorignore | |
| `*.svg` | indexing | SVG is often code; prefer indexing unless huge asset dirs |
| `*.mp4` | cursorignore | |
| `*.webm` | cursorignore | |
| `*.mp3` | cursorignore | |
| `*.wav` | cursorignore | |
| `*.pdf` | cursorignore | |
| `*.zip` | cursorignore | |
| `*.tar` | cursorignore | |
| `*.gz` | cursorignore | |
| `*.7z` | cursorignore | |
| `*.ttf` | cursorignore | |
| `*.woff` | cursorignore | |
| `*.woff2` | cursorignore | |
| `*.eot` | cursorignore | |
| `public/fonts/` | cursorignore | If exists |
| `*.wasm` | cursorignore | WebAssembly binaries |
| `*.map` | cursorignore | Source maps (generated, large) |
| `*.min.js` | cursorignore | Minified JavaScript |
| `*.min.css` | cursorignore | Minified CSS |
| `*.asar` | cursorignore | Electron archive |

Optional re-includes (add below media globs when matching paths exist):

```gitignore
!src/**
!app/**
!**/src/**/*.png
!**/app/**/*.png
!docs/**
!**/README.md
!**/.env.example
```

---

## Universal — lock & generated (de-index)

| Pattern | Target | Notes |
|---------|--------|-------|
| `package-lock.json` | indexing | |
| `yarn.lock` | indexing | |
| `pnpm-lock.yaml` | indexing | |
| `poetry.lock` | indexing | |
| `Pipfile.lock` | indexing | |
| `uv.lock` | indexing | |
| `Cargo.lock` | indexing | |
| `composer.lock` | indexing | |
| `Gemfile.lock` | indexing | |
| `go.sum` | indexing | |
| `*.generated.*` | indexing | |
| `graphql/generated/` | indexing | If exists |
| `**/openapi.generated.*` | indexing | |
| `**/__snapshots__/` | indexing | Jest / Vitest |
| `*.snap` | indexing | Large snapshot files |
| `bun.lockb` | indexing | Bun lock file (binary) |
| `bun.lock` | indexing | Bun lock file (text, newer) |
| `deno.lock` | indexing | Deno lock file |

---

## Conditional — add if present

| Path / pattern | Target | Condition |
|----------------|--------|-----------|
| `.terraform/` | cursorignore | Terraform |
| `*.tfstate` | cursorignore | Secrets risk |
| `*.tfstate.*` | cursorignore | |
| `.terragrunt-cache/` | cursorignore | |
| `*.csv` | cursorignore | Data dumps in repo |
| `*.parquet` | cursorignore | |
| `*.feather` | cursorignore | |
| `*.arrow` | cursorignore | |
| `*.ipynb_checkpoints/` | cursorignore | Jupyter |
| `.jupyter/` | cursorignore | |
| `wandb/` | cursorignore | ML experiment logs |
| `mlruns/` | cursorignore | MLflow |
| `.dvc/` | cursorignore | DVC cache metadata |
| `prisma/migrations/` | indexing | Prisma SQL history |
| `**/migrations/**/*.sql` | indexing | ORM migrations only |
| `*.sql` | indexing | **Only** if SQL is migration/history, not primary app source |
| `.vercel/` | cursorignore | Vercel build cache |
| `.netlify/` | cursorignore | |
| `firebase-debug.log` | cursorignore | |
| `.firebase/` | cursorignore | |
| `android/.gradle/` | cursorignore | Android |
| `android/app/build/` | cursorignore | |
| `ios/build/` | cursorignore | |
| `DerivedData/` | cursorignore | Xcode |
| `*.xcworkspace/xcuserdata/` | cursorignore | |
| `*.xcodeproj/xcuserdata/` | cursorignore | |
| `.dart_tool/` | cursorignore | Flutter |
| `.flutter-plugins` | cursorignore | |
| `.pub-cache/` | cursorignore | If vendored in repo |
| `build/` | cursorignore | Flutter `build/` (when `pubspec.yaml` exists) |
| `.husky/` | indexing | Git hooks directory |
| `*.war` | cursorignore | Java EE archives |
| `*.ear` | cursorignore | Java EE archives |
| `*.nupkg` | cursorignore | .NET NuGet packages |
| `packages/` | cursorignore | Old-style NuGet packages folder (only if not source) |
| `.nuget/` | cursorignore | NuGet cache |
| `*.egg` | cursorignore | Python zipped distributions |
| `.pixi/` | cursorignore | Pixi (conda-based) cache |
| `.conda/` | cursorignore | Conda environments (if in-repo) |

**Do not add `*.sql` globally** when the project is SQL-first: main code under `db/`, `sql/`, `migrations/` as edited source, or no ORM migration folder.

---

## Stack-specific patterns

See [annexes/INDEX.md](annexes/INDEX.md). Detection: [stack-signals.md](stack-signals.md).

Protection `!` block and dedupe: [CURSORIGNORE-FORMAT.md](CURSORIGNORE-FORMAT.md), [GITIGNORE-DEDUPE.md](GITIGNORE-DEDUPE.md).
