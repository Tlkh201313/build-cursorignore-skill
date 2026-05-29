# Repository manifest (build-cursorignore v1)

Cursor Agent skill bundle. **Ship repo:** this repository (structure aligned with [cursor-landing-v3](https://github.com/rphoward/cursor-landing-v3)). Flat install: `~/.cursor/skills/build-cursorignore/SKILL.md`. Slash: **`/build-cursorignore`**.

## Required layout

```text
SKILL.md                              ← workflow (/build-cursorignore); thin loader
README.md                             ← human quick start
OVERVIEW.md                           ← human positioning
BUNDLE-MANIFEST.md                    ← this file
LICENSE
.gitignore

references/
  ignore-checklist.md                 ← agent scan/write checklist (Phase 0–2)
  stack-signals.md                    ← how to detect stack from repo root
  patterns-catalog.md                 ← universal + conditional patterns
  GITIGNORE-DEDUPE.md                 ← skip-list rules vs .gitignore
  CURSORIGNORE-FORMAT.md              ← .cursorignore write order + markers
  CURSORINDEXINGIGNORE-FORMAT.md      ← .cursorindexingignore write order
  install.md                          ← flat copy to ~/.cursor/skills/build-cursorignore/
  troubleshooting.md
  cursor-notes.md                     ← Cursor-only execution notes
  examples/
    report-example.md                 ← chat closeout template
    nextjs.md
    python.md
  annexes/
    INDEX.md
    node.md
    nextjs.md
    python.md
    go.md
    rust.md
    jvm.md
    ruby.md
    php.md
    dotnet.md
    flutter.md
    mobile.md
    terraform.md
    data-ml.md

assets/
  cursorignore.baseline.template
  cursorindexingignore.baseline.template

scripts/README.md                     ← reserved (no scanner in v1)
```

## Authority map

| Topic | Source |
|-------|--------|
| Workflow steps | `SKILL.md` (thin) + [ignore-checklist.md](references/ignore-checklist.md) |
| Stack detection | [stack-signals.md](references/stack-signals.md) |
| Universal patterns | [patterns-catalog.md](references/patterns-catalog.md) |
| Per-stack patterns | [references/annexes/](references/annexes/INDEX.md) |
| `.gitignore` dedupe | [GITIGNORE-DEDUPE.md](references/GITIGNORE-DEDUPE.md) |
| File shape / markers | [CURSORIGNORE-FORMAT.md](references/CURSORIGNORE-FORMAT.md), [CURSORINDEXINGIGNORE-FORMAT.md](references/CURSORINDEXINGIGNORE-FORMAT.md) |
| Baseline copy-paste | `assets/*.template` |
| Human docs only | `README.md`, `OVERVIEW.md` |

## Format notes

| File | Format |
|------|--------|
| `SKILL.md` | YAML frontmatter (`name`, `description`) + markdown body |
| `references/*.md`, annexes | Markdown (human + agent reference) |
| `assets/*.template` | Raw gitignore-syntax pattern lists |

## Install check

- `~/.cursor/skills/build-cursorignore/SKILL.md` exists (no extra folder layer under skill name)
- `~/.cursor/skills/build-cursorignore/references/patterns-catalog.md` exists
- `/build-cursorignore` appears in Cursor Agent `/` menu after restart
- Running on a **target app repo** writes `.cursorignore` and/or `.cursorindexingignore` plus a chat report

## Versioning

- **v1** — two-file split, `.gitignore` dedupe, `!` protection, annexes per stack, landing-v3 layout.
