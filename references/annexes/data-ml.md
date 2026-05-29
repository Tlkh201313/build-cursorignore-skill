# Annex: Data / ML

**Detect:** `*.ipynb`, `dvc.yaml`, `wandb/`, `mlruns/`

| Pattern | Target |
|---------|--------|
| `*.ipynb_checkpoints/` | cursorignore |
| `wandb/`, `mlruns/` | cursorignore |
| `*.parquet`, `*.csv` | cursorignore | Large committed data only |
| `.dvc/cache` | cursorignore | If path exists |
