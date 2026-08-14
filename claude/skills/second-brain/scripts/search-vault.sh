#!/usr/bin/env bash
# Usage: search-vault.sh <query> [content|files] [vault-path] [--include-archive]
set -euo pipefail

QUERY="${1:?usage: search-vault.sh <query> [content|files] [vault-path] [--include-archive]}"
MODE="${2:-content}"
VAULT="${3:-.}"
MAX_RESULTS=100

GLOBS=(--glob '*.md' --glob '!99 Sensitive Review/**' --glob '!.obsidian/**' --glob '!_assets/**')
if [[ "${4:-}" != "--include-archive" ]]; then
    GLOBS+=(--glob '!90 Archive/**')
fi

if [[ "$MODE" == "files" ]]; then
    rg --files "${GLOBS[@]}" "$VAULT" | grep -iF -- "$QUERY" | head -n "$MAX_RESULTS"
else
    rg --fixed-strings --ignore-case --line-number --no-heading --color never "${GLOBS[@]}" -- "$QUERY" "$VAULT" | head -n "$MAX_RESULTS"
fi
