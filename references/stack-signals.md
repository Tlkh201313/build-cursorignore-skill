# Stack signals

Detect stack from **target repo root** (existence checks only — no speculative patterns).

| Signal file / path | Stack annex |
|--------------------|-------------|
| `package.json` | [annexes/node.md](annexes/node.md) |
| `next.config.js`, `next.config.mjs`, `next.config.ts`, or `"next"` in `package.json` | [annexes/nextjs.md](annexes/nextjs.md) (includes Node) |
| `pyproject.toml`, `requirements.txt`, `setup.py`, `Pipfile` | [annexes/python.md](annexes/python.md) |
| `go.mod` | [annexes/go.md](annexes/go.md) |
| `Cargo.toml` | [annexes/rust.md](annexes/rust.md) |
| `pom.xml` | [annexes/jvm.md](annexes/jvm.md) (Maven) |
| `build.gradle`, `build.gradle.kts` | [annexes/jvm.md](annexes/jvm.md) (Gradle) |
| `Gemfile` | [annexes/ruby.md](annexes/ruby.md) |
| `composer.json` | [annexes/php.md](annexes/php.md) |
| `*.csproj`, `*.sln`, `global.json` | [annexes/dotnet.md](annexes/dotnet.md) |
| `pubspec.yaml` | [annexes/flutter.md](annexes/flutter.md) |
| `ios/`, `android/`, `*.xcodeproj` | [annexes/mobile.md](annexes/mobile.md) |
| `*.tf`, `.terraform.lock.hcl` | [annexes/terraform.md](annexes/terraform.md) |
| `*.ipynb`, `dvc.yaml`, `wandb/`, `mlruns/` | [annexes/data-ml.md](annexes/data-ml.md) |
| `pnpm-workspace.yaml` | [annexes/monorepo.md](annexes/monorepo.md) (pnpm workspaces) |
| `nx.json` | [annexes/monorepo.md](annexes/monorepo.md) (Nx) |
| `turbo.json` | [annexes/monorepo.md](annexes/monorepo.md) (Turborepo) |
| `lerna.json` | [annexes/monorepo.md](annexes/monorepo.md) (Lerna) |
| `bun.lockb` or `bun.lock` or `bunfig.toml` | [annexes/bun.md](annexes/bun.md) |
| `deno.json` or `deno.jsonc` | [annexes/deno.md](annexes/deno.md) |
| `Dockerfile` or `docker-compose.yml` or `docker-compose.yaml` | [annexes/docker.md](annexes/docker.md) |
| `.github/workflows/` or `.gitlab-ci.yml` or `Jenkinsfile` or `.circleci/` or `.travis.yml` | [annexes/ci.md](annexes/ci.md) |

Apply **all** annexes whose signals match. Universal patterns always apply first: [patterns-catalog.md](patterns-catalog.md).
