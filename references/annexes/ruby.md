# Annex: Ruby

**Detect:** `Gemfile`

| Pattern | Target |
|---------|--------|
| `vendor/bundle/` | cursorignore |
| `.bundle/` | cursorignore |
| `Gemfile.lock` | indexing |
| `log/`, `tmp/` | cursorignore | Skip if already in `.gitignore` |
