# Scripts (reserved)

v1 scan is **checklist-driven** via [references/ignore-checklist.md](../references/ignore-checklist.md) and [references/patterns-catalog.md](../references/patterns-catalog.md)—no bundled executable.

Add read-only helper scripts here only if dogfood shows agents repeatedly miss the same signals. Any script must infer shell from the repo, emit markdown, and fall back to the checklist on failure.

Install: flat copy per [references/install.md](../references/install.md) — no install script in v1.
