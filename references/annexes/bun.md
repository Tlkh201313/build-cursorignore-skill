# Annex: Bun

**Detect:** `bun.lockb`, `bun.lock`, or `bunfig.toml`

| Pattern | Target |
|---------|--------|
| `bun.lockb` | indexing |
| `bun.lock` | indexing |
| `.bun/` | cursorignore |
| `node_modules/` | cursorignore | Already in universal |
