# Importance Tiers

Classification system for AI to understand file relevance when scanning a repository.

## Tier Definitions

| Tier | Name | Index Status | Readable | Description | Examples |
|------|------|--------------|----------|-------------|----------|
| **T1** | Source | Indexed | Always | Core application code the developer edits | `src/`, `app/`, `lib/`, `*.py`, `*.ts`, `*.go` |
| **T2** | Config | Indexed | Always | Configuration files that control behavior | `package.json`, `tsconfig.json`, `*.config.*`, `.env.example` |
| **T3** | Reference | De-indexed | On request | Documentation, examples, lock files | `docs/`, `*.md`, `package-lock.json`, `*.lock` |
| **T4** | Noise | De-indexed | Rarely | Generated code, test artifacts, snapshots | `*.generated.*`, `__snapshots__/`, `*.snap` |
| **T5** | Junk | Blocked | Never | Dependencies, build output, binaries | `node_modules/`, `dist/`, `*.exe`, `*.png` |

## Mapping to Ignore Files

| Tier | Maps To | Action |
|------|---------|--------|
| T1 (Source) | Neither | Always indexed, always readable |
| T2 (Config) | Neither | Always indexed, always readable |
| T3 (Reference) | `.cursorindexingignore` | De-indexed, openable on request |
| T4 (Noise) | `.cursorindexingignore` | De-indexed, openable on request |
| T5 (Junk) | `.cursorignore` | Fully blocked |

## AI Decision Guide

When deciding what to read:

1. **Start with T1 (Source)** — this is the actual code
2. **Check T2 (Config)** — understand project structure and settings
3. **Reference T3 (T4/T5)** — only if needed for specific questions
4. **Skip T5 (Junk)** — never useful for understanding codebase

## Pattern Examples by Tier

### T1 — Source
```
src/**
app/**
lib/**
**/*.py
**/*.ts
**/*.js
**/*.go
**/*.rs
**/*.java
**/*.rb
**/*.php
**/*.cs
!**/*.test.*
!**/*.spec.*
```

### T2 — Config
```
package.json
tsconfig.json
*.config.*
.env.example
.gitignore
.dockerignore
Makefile
```

### T3 — Reference
```
docs/**
**/*.md
**/README.md
examples/**
**/LICENSE
package-lock.json
yarn.lock
pnpm-lock.yaml
poetry.lock
Cargo.lock
go.sum
```

### T4 — Noise
```
**/*.generated.*
graphql/generated/**
**/__snapshots__/**
**/*.snap
**/openapi.generated.*
next-env.d.ts
```

### T5 — Junk
```
node_modules/
.venv/
vendor/
dist/
build/
out/
.next/
.nuxt/
.cache/
*.pyc
*.class
*.exe
*.dll
*.so
*.dylib
*.wasm
*.map
*.min.js
*.min.css
*.png
*.jpg
*.jpeg
*.gif
*.ico
*.webp
*.mp4
*.pdf
*.ttf
*.woff
*.woff2
*.log
logs/
coverage/
.idea/
.DS_Store
Thumbs.db
```

## Integration with Skill Workflow

### Phase 0 — Scan
When scanning, assign each discovered file/pattern to a tier.

### Phase 1 — Plan
Present the plan grouped by tier:
```
## T1 — Source (always readable)
- src/**
- app/**

## T3 — Reference (de-indexed)
- package-lock.json
- docs/**

## T5 — Junk (blocked)
- node_modules/
- dist/
```

### Phase 2 — Write
- T1/T2: No action needed (always indexed)
- T3/T4: Write to `.cursorindexingignore`
- T5: Write to `.cursorignore`

### Phase 3 — Report
Include tier breakdown in the closeout report:
```
Blocked 15 patterns (T5 Junk), De-indexed 8 patterns (T3/T4 Reference/Noise)
```

## Token Budget Guidance

For large repos, prioritize reading by tier:
| Tier | Token Budget | When to Read |
|------|--------------|--------------|
| T1 | 80% | Always |
| T2 | 15% | When understanding config |
| T3 | 4% | When specific questions |
| T4 | 1% | Rarely |
| T5 | 0% | Never |
