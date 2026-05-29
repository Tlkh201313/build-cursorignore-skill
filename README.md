# build-cursorignore

> Auto-generate `.cursorignore` and `.cursorindexingignore` for any project. One command, zero config.

[![Cursor Compatible](https://img.shields.io/badge/Cursor-Compatible-black?logo=cursor)](https://cursor.com) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)

## Why

Large repos are noisy. Build artifacts, caches, vendor folders, logs, and generated code bloat Cursor's context window and slow indexing — causing the agent to wade through thousands of irrelevant files before it reaches code that matters.

`build-cursorignore` scans your project, detects the stack from indicator files, and writes the right ignore rules automatically. It blocks what the agent should never see and de-indexes what's only occasionally useful.

## What it does

- Detects your stack from indicator files (`package.json`, `Cargo.toml`, `go.mod`, `pyproject.toml`, etc.)
- Writes `.cursorignore` (hard block) and `.cursorindexingignore` (soft de-index)
- Handles monorepos — detects stacks per workspace package and merges rules
- Never duplicates `.gitignore` rules that Cursor already respects
- Uses managed blocks — your custom rules outside the block are never touched on re-run

## Quick start

### Install

```bash
npx skills add Tlkh201313/build-cursorignore-skill -a cursor
```

### Run

Open a Cursor Agent chat and type:

```
/build-cursorignore
```

The skill scans the repo, detects your stack, writes both ignore files, and reports what changed.

---

## The two files

| File | Effect | Still accessible with `@`? |
|---|---|---|
| `.cursorignore` | Hard block — agent cannot open or read the file at all | No |
| `.cursorindexingignore` | Soft de-index — excluded from automatic context, but reachable on request | Yes |

When in doubt, prefer `.cursorindexingignore`. Reserve `.cursorignore` for things the agent should never touch: compiled binaries, vendor deps, build output.

---

## What gets blocked

### Always (baseline)

**Dependencies**
`node_modules/` · `.venv/` · `venv/` · `vendor/` · `__pycache__/` · `*.pyc`

**Build output**
`dist/` · `build/` · `out/` · `.next/` · `.nuxt/` · `.svelte-kit/` · `target/` · `storybook-static/`

**Caches**
`.cache/` · `.turbo/` · `.nx/` · `.parcel-cache/` · `.eslintcache` · `*.tsbuildinfo`

**Test coverage and output**
`coverage/` · `.nyc_output/` · `.pytest_cache/` · `playwright-report/` · `test-results/`

**Compiled / binary files**
`*.wasm` · `*.class` · `*.o` · `*.a` · `*.dylib` · `*.exe` · `*.dll` · `*.so`

**Large static assets** *(images, media, archives)*
`*.png` · `*.jpg` · `*.pdf` · `*.mp4` · `*.zip` · `*.tar.gz`

**Generated web assets**
`*.map` · `*.min.js` · `*.min.css`

**Logs, temp, OS noise**
`*.log` · `logs/` · `*.tmp` · `.DS_Store` · `Thumbs.db`

### Soft de-indexed (baseline)

`package-lock.json` · `yarn.lock` · `*.lock` · `*.lockb` · `*.snap` · `__snapshots__/` · `*.generated.*` · `*.pb.go` · `*.pb.ts` · `_generated/` · `*.d.ts` · `migrations/`

### Stack-specific extras

| Stack | Extra patterns |
|---|---|
| Yarn Berry | `.yarn/cache/` `.yarn/install-state.gz` |
| Bun | `.bun/` |
| Deno | `.deno/` |
| Rust | `.cargo/registry/` `.cargo/git/` |
| Go | `vendor/` (when `go.sum` present) |
| JVM / Gradle | `.gradle/` `*.jar` `*.war` `*.ear` |
| JVM / Maven | `.m2/` `*.jar` |
| .NET | `obj/` `*.nupkg` `bin/` (only when `.csproj`/`.sln` present) |
| Ruby | `vendor/bundle/` `.bundle/` |
| Flutter / Dart | `.dart_tool/` `*.g.dart` `*.freezed.dart` |
| Android | `android/.gradle/` `android/build/` |
| iOS | `ios/build/` `DerivedData/` `Pods/` |
| Python | `.eggs/` `*.egg-info/` |
| Terraform | `.terraform/` `*.tfstate` `*.tfstate.backup` |
| Elixir | `_build/` `deps/` |
| CMake / C++ | `cmake-build-*/` `_deps/` `.ccache/` |
| Haskell | `.stack-work/` |

---

## Supported stacks

| Category | Stacks |
|---|---|
| JavaScript / TypeScript | Node.js, Next.js, Nuxt, SvelteKit, Vite, Remix, Astro |
| Package managers | npm, Yarn Classic, Yarn Berry, Bun, Deno, pnpm |
| Python | Generic Python, Django, Flask |
| Systems | Rust, Go, C/C++ (CMake), Haskell |
| JVM | Java, Kotlin, Scala (Gradle + Maven) |
| Mobile | iOS/Swift, Android, React Native, Flutter/Dart |
| Backend / infra | Ruby, Rails, PHP, Elixir, .NET, Terraform |

Monorepos are supported. The skill scans each workspace package and merges the detected stacks into a single set of rules.

---

## Example output

`.cursorignore`:

```
# --- build-cursorignore ---
node_modules/
.venv/
__pycache__/
dist/
.next/
.cache/
.turbo/
coverage/
*.log
*.map
*.min.js
*.png
*.jpg
.DS_Store

!src/
!app/
!components/
!pages/
!*.config.*
!*.test.*
# --- /build-cursorignore ---
```

`.cursorindexingignore`:

```
# --- build-cursorignore ---
package-lock.json
yarn.lock
*.lock
*.snap
__snapshots__/
*.generated.*
*.d.ts
migrations/
# --- /build-cursorignore ---
```

---

## Safe to re-run

All managed rules live inside clearly fenced blocks:

```
# --- build-cursorignore ---
... auto-generated rules ...
# --- /build-cursorignore ---
```

Anything you write outside the block is left alone. Re-run `/build-cursorignore` any time your stack changes or you add new workspace packages.

---

## Verify it worked

1. Restart Cursor after the files are written so the new rules are loaded.
2. Wait for re-indexing to complete.
3. Open a new Agent chat and ask `@Codebase` about something inside an ignored path — for example, a package inside `node_modules/`. It should not appear in results unless you reference it directly with `@`.

---

## FAQ

**Does this replace my existing ignore files?**
No. Rules are written inside managed blocks. Everything outside those blocks is untouched.

**Do I need to duplicate my `.gitignore` rules?**
No. Cursor respects `.gitignore` automatically. The skill never duplicates rules already covered there.

**Can I still open a hard-blocked file?**
Files in `.cursorindexingignore` can still be opened directly with `@`. Files in `.cursorignore` are fully blocked — the agent cannot access them at all.

**Should I commit these files?**
Yes. Commit both files. They are project configuration, and committing them means every contributor and every CI environment gets the same context behaviour without running the skill again.

**Will this hide my source code?**
No. The skill adds re-include rules (`!src/`, `!app/`, `!components/`, `!*.config.*`, etc.) to protect common source paths from accidental silencing. If your project uses a non-standard source layout, review the generated files before committing.

**What about `.env` files?**
The skill does not touch `.env` files. They are usually already in `.gitignore`. If you want to hard-block them from the agent, add them to `.cursorignore` manually.

**What about SVG files?**
SVG files are not blocked globally because they are often React or Vue source components. The skill instead blocks `public/**/*.svg` (static assets) while leaving component SVGs accessible.

---

## Update / uninstall

```bash
# Update
npx skills update build-cursorignore

# Uninstall
npx skills remove build-cursorignore
```

---

## Contributing

Issues and pull requests are welcome.

## License

MIT
