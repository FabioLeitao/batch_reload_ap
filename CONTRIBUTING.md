# Contributing

## Scope

Issues and PRs should stay **generic**: no live passwords, internal DNS zones, or customer AP inventories in tracked files.

## Proposals

- For new zone list layouts or extra safety checks (dry-run, parallel limits), open an issue first with a short design note.

## Local checks

- `shellcheck batch_reload.sh` (if installed).
- Run `bash -n batch_reload.sh` and test `expect` against a **lab** device only.
