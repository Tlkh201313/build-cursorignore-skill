# Annex: Python

**Detect:** `pyproject.toml`, `requirements.txt`, `setup.py`, `Pipfile`

| Pattern | Target |
|---------|--------|
| `.venv/`, `venv/` | cursorignore |
| `__pycache__/` | cursorignore |
| `*.pyc` | cursorignore |
| `.mypy_cache/` | cursorignore |
| `.pytest_cache/` | cursorignore |
| `.ruff_cache/` | cursorignore |
| `.tox/`, `.nox/` | cursorignore |
| `htmlcov/`, `coverage/`, `.coverage` | cursorignore |
| `dist/`, `build/`, `*.egg-info/` | cursorignore |
| `poetry.lock`, `Pipfile.lock`, `uv.lock` | indexing |

Example output: [examples/python.md](../examples/python.md).
