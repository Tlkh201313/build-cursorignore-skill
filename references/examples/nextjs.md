# Example: Next.js app

Sample repo layout:

```text
my-app/
  package.json          # "next": "15.x"
  next.config.ts
  .gitignore            # includes node_modules, .next
  src/
    app/
    components/
  public/
    logo.png
  package-lock.json
```

## What the skill should do

1. Read `.gitignore` — skip `node_modules/`, `.next/` (already covered).
2. Detect Next.js via `package.json` + `next.config.ts`.
3. Write `.cursorignore` with net-new patterns only.
4. Put `package-lock.json` in `.cursorindexingignore`.
5. Append protection `!` lines so `src/` and `public/` assets under app code stay reachable.

## Example `.cursorignore` (excerpt)

```gitignore
# build-cursorignore — net-new only (.gitignore already has node_modules, .next)

dist/
out/
.vercel/
.turbo/
.cache/
coverage/
*.log

*.png
*.jpg
*.jpeg
*.gif
*.ico
*.webp
*.woff2

.DS_Store
.idea/

# --- build-cursorignore: do not block editable source ---
!**/src/**
!**/app/**
!**/*.test.*
!**/*.spec.*
!**/.env.example
!**/README.md
!next.config.*
!tsconfig.json
!**/public/**/logo.png
```

## Example `.cursorindexingignore`

```gitignore
package-lock.json
next-env.d.ts
```

## Example chat report

See [report-example.md](report-example.md). Sample:

> **Done.** Blocked 12 net-new paths in `.cursorignore` (2 in `.cursorindexingignore`). Top wins: `*.png` (assets in `public/`), `.vercel/`, `coverage/`. Patterns already in `.gitignore` were skipped (`node_modules/`, `.next/`). Reindex or restart Cursor to apply.
