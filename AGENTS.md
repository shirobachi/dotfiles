# AGENTS

## Requests

- Commit style: **concise, English, with a `[tag]` prefix** (e.g. `[backup] add ...`). No Co-Authored-By.
- Send shell/tool commands **one at a time** — no batches, no parallel tool calls.
- Before running any commit or push sequence, ensure your working directory is clean and the stash is empty. Use the following command chain:
  - `[ -z "$(git stash list)" ] && git status && git add . && git commit -m "<your-message>" && git pull && git push`
