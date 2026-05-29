# README.md Improvements Plan

I will upgrade the README with:

* **Small visual previews (SM pics)** near key sections:

  * Before/after indexing impact
  * Generated `.cursorignore` example
  * Cursor Agent command screenshot/GIF
  * Repo scan → generated files mini flow
* **More interaction**:

  * Collapsible FAQ (`<details>`)
  * Copy-paste command blocks
  * "Try this test" section
  * Architecture flow diagram using Mermaid
  * Badges and quick-jump navigation
* **Stronger OSS presentation**:

  * Better hero section
  * Clearer problem → solution framing
  * Cleaner install/run UX
  * More trust and credibility

# OVERVIEW.md (Draft Structure)

## What is build-cursorignore?

A higher-level explanation of what the skill does, why Cursor context gets noisy, and when to use this skill.

## The Problem

Modern repositories contain large amounts of irrelevant content:

* build artifacts
* dependency folders
* generated files
* logs and caches
* vendor packages
* IDE metadata

Without filtering, Cursor may waste context windows and indexing resources on files that do not improve coding assistance.

## The Solution

`build-cursorignore` automatically generates optimized:

* `.cursorignore`
* `.cursorindexingignore`

based on your project structure and detected frameworks.

Instead of manually tuning ignore files for every stack, the skill builds a practical baseline automatically.

## How It Works

```mermaid
flowchart LR
    A[Scan Repository] --> B[Detect Stacks]
    B --> C[Generate Rules]
    C --> D[Write Managed Blocks]
    D --> E[Cursor Re-indexes]
```

### Detection

The skill scans for indicators such as:

* `package.json`
* `requirements.txt`
* `Cargo.toml`
* `go.mod`
* `Gemfile`
* framework-specific config files

It supports mixed repositories and monorepos.

### Rule Generation

The skill combines:

1. Universal ignore rules
2. Framework-specific exclusions
3. Security-sensitive patterns
4. Large generated output folders

Example:

```text
node_modules/
dist/
.next/
coverage/
.cache/
*.log
```

## Cursor Ignore Types

### `.cursorignore`

A hard exclusion layer.

Files here are intentionally removed from AI context.

Use for:

* dependency trees
* generated assets
* binaries
* secrets

### `.cursorindexingignore`

An indexing optimization layer.

Files are not indexed but can still be referenced manually using `@`.

Use for:

* archived code
* large docs
* generated SDKs
* vendor libraries you occasionally inspect

## Why This Helps

Benefits often include:

* Faster indexing
* Cleaner `@Codebase` results
* Lower token waste
* Better code relevance
* Less noise in agent reasoning

## Safe By Design

The skill writes inside **managed blocks**, preserving custom rules outside them.

```text
# >>> build-cursorignore:baseline BEGIN >>>
... generated rules ...
# <<< build-cursorignore:baseline END <<<
```

This means you can rerun the skill at any time without losing manual edits.

## Recommended Workflow

1. Install the skill
2. Run `/build-cursorignore`
3. Open a fresh Cursor Agent session
4. Wait for indexing to finish
5. Validate ignored paths
6. Rerun after major repo changes

## When To Use It

Recommended for:

* monorepos
* enterprise repos
* large TypeScript apps
* AI-assisted coding workflows
* teams using Cursor heavily
* repos with excessive generated output

Less useful for:

* very small repos
* short-lived prototypes
* simple single-folder scripts

## Philosophy

Cursor works best when context quality is high.

The goal of `build-cursorignore` is not to hide code — it is to reduce noise so Cursor spends more attention on the files that matter most.
