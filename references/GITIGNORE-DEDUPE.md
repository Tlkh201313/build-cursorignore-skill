# .gitignore dedupe

Cursor already ignores everything in `.gitignore`. **Never re-list** those patterns in `.cursorignore` or `.cursorindexingignore` — duplicates add noise only.

## Normalize before compare

- Strip leading `/` (`/dist` → `dist`).
- Treat `dist` and `dist/` as equivalent for directories.
- Ignore comment-only and blank lines.
- Lowercase is not required (gitignore is case-sensitive on case-sensitive FS).

## Skip rules

Before adding pattern `P`:

| Condition | Action |
|-----------|--------|
| `.gitignore` contains `P`, `P/`, or `/${P}` | **Skip** |
| Parent rule covers children (e.g. `node_modules` covers `node_modules/foo/`) | **Skip** `node_modules/` |
| Uncertain whether covered | **Skip** (prefer duplicate in gitignore over wrong add) |

## Cheat sheet

| `.gitignore` has | Do not add |
|------------------|------------|
| `node_modules` | `node_modules/` |
| `/dist` | `dist/` |
| `*.log` | `*.log` |
| `.env` | (secrets — usually gitignored already) |

## Verify (optional)

When unsure, check a sample path: `git check-ignore -v <path>` — if ignored, skip the Cursor pattern.
