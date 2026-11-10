#!/usr/bin/env bash
set -euo pipefail
ROOT="${CI_PROJECT_DIR:-$(git rev-parse --show-toplevel)}"
cd "$ROOT"
"$ROOT/infra/scripts/ci/validate-repo.sh" --root "$ROOT"
"$ROOT/infra/scripts/ci/check-size.sh" --root "$ROOT"
"$ROOT/infra/scripts/ci/validate-local-issues.sh" --root "$ROOT"
while IFS= read -r f; do jq empty "$f"; done < <(find data schemas -type f -name '*.json' | sort)
for f in infra/scripts/*.sh; do bash -n "$f"; done
echo "database-stocks checks ok"
