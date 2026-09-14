#!/usr/bin/env bash
set -euo pipefail

model_name="aicodex"
install_ollama=false
run_after=false

for arg in "$@"; do
  case "$arg" in
    --install-ollama) install_ollama=true ;;
    --run) run_after=true ;;
    *)
      printf 'Unknown option: %s\nUsage: %s [--install-ollama] [--run]\n' "$arg" "$0" >&2
      exit 2
      ;;
  esac
done

if ! command -v ollama >/dev/null 2>&1; then
  if [[ "$install_ollama" != true ]]; then
    printf '%s\n' 'Ollama was not found. Re-run with --install-ollama to use the official Ollama installer.' >&2
    exit 1
  fi

  printf '%s\n' 'Installing Ollama using the official installer...'
  curl -fsSL https://ollama.com/install.sh | sh
  hash -r
fi

if ! command -v ollama >/dev/null 2>&1; then
  printf '%s\n' 'Ollama installation did not put the command on PATH. Open a new terminal and run this script again.' >&2
  exit 1
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
modelfile="$repo_root/Modelfile"

if [[ ! -f "$modelfile" ]]; then
  printf 'Modelfile not found: %s\n' "$modelfile" >&2
  exit 1
fi

# On a normal Kali system the Ollama service is already running after installation.
# In minimal shells/containers, start a user-owned server only if one is not reachable.
if ! ollama list >/dev/null 2>&1; then
  log_file="${TMPDIR:-/tmp}/aicodex-ollama.log"
  printf 'Starting a local Ollama server (log: %s)...\n' "$log_file"
  nohup ollama serve >"$log_file" 2>&1 &
  for _ in {1..20}; do
    sleep 0.5
    if ollama list >/dev/null 2>&1; then
      break
    fi
  done
fi

if ! ollama list >/dev/null 2>&1; then
  printf '%s\n' 'Ollama is installed but its local server is unreachable. Run "ollama serve" in another terminal, then rerun this script.' >&2
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
