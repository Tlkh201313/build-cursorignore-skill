# Example: Python project

Sample repo layout:

```text
api/
  pyproject.toml
  .gitignore            # includes .venv, __pycache__, .pytest_cache
  src/
    api/
      main.py
  tests/
    test_main.py
  htmlcov/              # not in .gitignore
  poetry.lock
```

## What the skill should do

1. Skip patterns already in `.gitignore` (`.venv/`, `__pycache__/`, etc.).
2. Detect Python via `pyproject.toml`.
3. Block `htmlcov/` in `.cursorignore` (coverage HTML).
4. De-index `poetry.lock` in `.cursorindexingignore`.
5. Never block `tests/` or `src/` — use `!` if a broad glob would catch them.

## Example `.cursorignore` (excerpt)

```gitignore
# build-cursorignore

htmlcov/
.coverage
*.cover
.mypy_cache/
.ruff_cache/
dist/
*.egg-info/

*.log
.DS_Store

# --- build-cursorignore: do not block editable source ---
!**/src/**
!**/tests/**
!**/*.py
!**/.env.example
!**/README.md
```

Note: `!**/*.py` is used here only if a broader rule would block `.py` files (unusual). Normally Python projects do not glob-block `*.py`.

## Example `.cursorindexingignore`

```gitignore
poetry.lock
```

## Example chat report

See [report-example.md](report-example.md). Sample:

> **Done.** Blocked 8 net-new paths in `.cursorignore` (1 in `.cursorindexingignore`). Top wins: `htmlcov/`, `.mypy_cache/`, `dist/`. Skipped duplicates from `.gitignore` (`.venv/`, `__pycache__/`, `.pytest_cache/`). Reindex or restart Cursor to apply.
