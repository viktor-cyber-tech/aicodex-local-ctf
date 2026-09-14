#!/usr/bin/env bash
set -euo pipefail

model_name="aicodex"
run_after=false

for arg in "$@"; do
  case "$arg" in
    --run) run_after=true ;;
    *)
      printf 'Unknown option: %s\nUsage: %s [--run]\n' "$arg" "$0" >&2
      exit 2
      ;;
  esac
done

if ! command -v ollama >/dev/null 2>&1; then
  printf '%s\n' 'Ollama was not found. Install it from https://ollama.com/download, then run this script again.' >&2
  exit 1
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
modelfile="$repo_root/Modelfile"

if [[ ! -f "$modelfile" ]]; then
  printf 'Modelfile not found: %s\n' "$modelfile" >&2
  exit 1
fi

printf '%s\n' 'Downloading the Qwen2.5-Coder 14B base model (skips the download if already present)...'
ollama pull qwen2.5-coder:14b

printf "Building local model '%s' from the repository Modelfile...\n" "$model_name"
ollama create "$model_name" -f "$modelfile"

printf "AICodex is ready. Start it any time with: ollama run %s\n" "$model_name"

if [[ "$run_after" == true ]]; then
  ollama run "$model_name"
fi
