#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/config.sh"

DEFAULT_AGENT_CMD="codex exec --yolo --skip-git-repo-check -"
DEFAULT_MAX_ITERATIONS=2
NO_COMMIT=false
MAX_ITERATIONS="${DEFAULT_MAX_ITERATIONS}"
AGENT_CMD="${DEFAULT_AGENT_CMD}"

if [[ -f "${CONFIG_FILE}" ]]; then
  # shellcheck source=/dev/null
  source "${CONFIG_FILE}"
fi

MODE="build"
while [[ $# -gt 0 ]]; do
  case "$1" in
    build)
      shift
      ;;
    --no-commit)
      NO_COMMIT=true
      shift
      ;;
    *)
      if [[ "$1" =~ ^[0-9]+$ ]]; then
        MAX_ITERATIONS="$1"
        shift
      else
        echo "Unknown arg: $1"
        exit 1
      fi
      ;;
  esac
done

echo "Ralph loop placeholder: run ${MAX_ITERATIONS} iteration(s), no-commit=${NO_COMMIT}, agent=${AGENT_CMD}"
