# Annex: CI/CD

**Detect:** `.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`, `.circleci/`, `.travis.yml`

| Pattern | Target | Notes |
|---------|--------|-------|
| `.github/.cache/` | cursorignore | GitHub Actions cache |
| `artifacts/` | cursorignore | If not source |
| `test-results/` | cursorignore | CI test results |
| `.gitlab/` | cursorignore | GitLab-specific cache |
