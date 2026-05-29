# Annex: Monorepo / Workspaces

**Detect:** `pnpm-workspace.yaml`, `nx.json`, `turbo.json`, `lerna.json`, or `workspaces` in `package.json`

## Guidance

Monorepos contain multiple packages/apps. The skill should:

1. **Scan subdirectories** for nested stack signals (e.g., `packages/api/go.mod`, `apps/web/next.config.ts`)
2. **Apply all matching annexes** for each nested stack
3. **Shared dependencies** — `node_modules/` at root covers all packages

## Patterns

| Pattern | Target | Notes |
|---------|--------|-------|
| `.pnpm-store/` | cursorignore | pnpm global store (if in repo) |
| `.nx/` | cursorignore | Nx cache |
| `.turbo/` | cursorignore | Turborepo cache |
| `node_modules/` | cursorignore | Already in universal; covers monorepo layout |

## Per-package detection

When scanning, check these paths for nested stacks:
- `packages/*/`
- `apps/*/`
- `libs/*/`
- `tools/*/`

Each subdirectory may have its own `package.json`, `go.mod`, `Cargo.toml`, etc. Apply the appropriate annex for each.
