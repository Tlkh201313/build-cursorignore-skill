# Annex: Go

**Detect:** `go.mod`

| Pattern | Target |
|---------|--------|
| `vendor/` | cursorignore | If vendoring |
| `bin/` | cursorignore | If build output, not hand-written scripts |
| `go.sum` | indexing |
| `*.test` | indexing | Optional test binaries |
