# Annex: Terraform / IaC

**Detect:** `*.tf`, `.terraform.lock.hcl`

| Pattern | Target |
|---------|--------|
| `.terraform/` | cursorignore |
| `*.tfstate` | cursorignore | May contain secrets |
| `*.tfstate.*` | cursorignore |
| `.terragrunt-cache/` | cursorignore |
