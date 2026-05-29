# .cursorindexingignore format

**Effect:** path is **de-indexed** but still **openable** when the user or agent requests it.

**Syntax:** gitignore (globs, trailing `/`, `!` rare).

## Write order

1. Header comment: `# build-cursorignore`
2. Marked block: `# --- build-cursorignore ---` … `# --- end build-cursorignore ---`
3. Sections: `# Lock files`, `# Generated code`, `# Snapshots / migrations`
4. Net-new patterns only ([GITIGNORE-DEDUPE.md](GITIGNORE-DEDUPE.md)).

## Default contents (if present in repo)

| Pattern | Why indexing only |
|---------|-------------------|
| `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml` | Debug dependency resolution |
| `poetry.lock`, `Pipfile.lock`, `uv.lock`, `Cargo.lock`, `composer.lock`, `Gemfile.lock`, `go.sum` | Same |
| `*.generated.*`, `graphql/generated/` | Occasionally source of bugs |
| `**/__snapshots__/`, `*.snap` | Large test artifacts |
| `prisma/migrations/` | SQL history sometimes needed |

**When unsure**, prefer this file over `.cursorignore`.

Baseline: [assets/cursorindexingignore.baseline.template](../assets/cursorindexingignore.baseline.template).
