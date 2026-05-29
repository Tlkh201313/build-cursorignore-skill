# Stack annexes

Per-stack patterns for **build-cursorignore**. Each annex lists patterns and **target file**:

| Target | File |
|--------|------|
| `cursorignore` | `.cursorignore` |
| `indexing` | `.cursorindexingignore` |

**Before adding:** path exists · not in `.gitignore` · see [GITIGNORE-DEDUPE.md](../GITIGNORE-DEDUPE.md).

Universal patterns (all stacks): [patterns-catalog.md](../patterns-catalog.md).

| Annex | Detect |
|-------|--------|
| [node.md](node.md) | `package.json` |
| [nextjs.md](nextjs.md) | Next.js config or `"next"` in `package.json` |
| [python.md](python.md) | `pyproject.toml`, `requirements.txt`, `setup.py`, `Pipfile` |
| [go.md](go.md) | `go.mod` |
| [rust.md](rust.md) | `Cargo.toml` |
| [jvm.md](jvm.md) | `pom.xml`, `build.gradle`, `build.gradle.kts` |
| [ruby.md](ruby.md) | `Gemfile` |
| [php.md](php.md) | `composer.json` |
| [dotnet.md](dotnet.md) | `*.csproj`, `*.sln`, `global.json` |
| [flutter.md](flutter.md) | `pubspec.yaml` |
| [mobile.md](mobile.md) | `ios/`, `android/`, `*.xcodeproj` |
| [terraform.md](terraform.md) | `*.tf`, `.terraform.lock.hcl` |
| [data-ml.md](data-ml.md) | notebooks, DVC, MLflow, wandb |
| [monorepo.md](monorepo.md) | `pnpm-workspace.yaml`, `nx.json`, `turbo.json`, `lerna.json`, `workspaces` in package.json |
| [bun.md](bun.md) | `bun.lockb`, `bun.lock`, `bunfig.toml` |
| [deno.md](deno.md) | `deno.json`, `deno.jsonc` |
| [docker.md](docker.md) | `Dockerfile`, `docker-compose.yml`, `docker-compose.yaml` |
| [ci.md](ci.md) | `.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`, `.circleci/`, `.travis.yml` |

Detection table: [stack-signals.md](../stack-signals.md).
