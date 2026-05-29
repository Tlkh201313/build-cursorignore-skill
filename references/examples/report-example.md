# Report example (chat closeout)

**Phase 1 (plan):** summarize proposed patterns and ask: *“Reply OK to write these files.”* — no files yet.

**Phase 3 (after Phase 2 writes):** reply in this shape:

> **Done.** Blocked **N** net-new paths in `.cursorignore` (**M** in `.cursorindexingignore`). Top wins: **[pattern 1]** — [why]; **[pattern 2]** — [why]; **[pattern 3]** — [why]. Patterns already in `.gitignore` were skipped. Reindex or restart Cursor to apply.

If nothing net-new:

> **Done.** No new patterns needed — `.gitignore` already covers the heavy paths. Consider de-indexing: [1–2 optional `.cursorindexingignore` suggestions]. Reindex or restart Cursor to apply.

Do not claim paths were blocked if they were only skipped as duplicates.
