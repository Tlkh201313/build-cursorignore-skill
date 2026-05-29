# Annex: Docker

**Detect:** `Dockerfile`, `docker-compose.yml`, `docker-compose.yaml`

| Pattern | Target | Notes |
|---------|--------|-------|
| `.docker/` | cursorignore | Docker build context |
| `docker-compose.override.yml` | indexing | Local overrides |
| `*.tar` | cursorignore | Docker save output (if present) |
