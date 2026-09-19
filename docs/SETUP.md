# Setup

## Prerequisites

- Ollama installed and available in your terminal. Get it from [ollama.com/download](https://ollama.com/download).
- Git installed.
- At least 12 GB free disk space for the base model and local cache.
- 32 GB RAM is recommended for `qwen2.5-coder:14b`; 16 GB may work but can be substantially slower.

## Performance recommendation

Run Ollama and AICodex directly on the host operating system—Windows or Linux—for the best use of available CPU, system memory, and supported GPU acceleration. Running the model inside a virtual machine adds resource limits and virtualization overhead.

If you use Kali in VirtualBox or another VM, keep it as a separate terminal for authorized CTF tools. Run AICodex on the host, then copy commands into Kali when you need its tools.

## Clone and build

### Windows PowerShell

```powershell
git clone https://github.com/viktor-cyber-tech/aicodex-local-ctf.git
cd aicodex-local-ctf
.\scripts\setup-aicodex.ps1 -Run
```

If execution policy prevents the script from starting, use this temporary, current-terminal-only setting:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\setup-aicodex.ps1 -Run
```

### Kali Linux, Debian, or WSL

```bash
git clone https://github.com/viktor-cyber-tech/aicodex-local-ctf.git
cd aicodex-local-ctf
bash scripts/setup-aicodex.sh --install-ollama --run
```

The `--install-ollama` flag uses [Ollama’s official Linux installer](https://docs.ollama.com/) only if Ollama is missing. Omit that flag after the first install.

Both scripts:

1. Check that Ollama is installed; the Bash script can install it when passed `--install-ollama`.
2. Download `qwen2.5-coder:14b` if necessary.
3. Build or rebuild the local `aicodex` model using the repository’s `Modelfile`.
4. Start `ollama run aicodex` when passed `-Run` or `--run`.

You can reopen it later from any folder:

```text
ollama run aicodex
```

## Manual Ollama CLI

From the cloned repository folder, these commands perform the same model download, build, and launch without using a helper script:

```bash
ollama pull qwen2.5-coder:14b
ollama create aicodex -f ./Modelfile
ollama run aicodex
```

In Windows PowerShell, `ollama create aicodex -f .\\Modelfile` is equivalent.

Confirm it exists:

```text
ollama list
```

## Recommended prompts

### Command generation

```text
Authorized offline CTF on Kali Linux.
Return only one copyable Bash command—no explanation.
[describe the supplied artifact and desired transformation]
```

### PowerShell 5.1 compatibility

```text
This is an authorized CTF. Give a Windows PowerShell 5.1-compatible command.
Do not use APIs introduced after Windows PowerShell 5.1.
```

## Use a separate terminal

The Ollama CLI is a chat interface; it does not execute generated commands. Keep AICodex open in one terminal and run the generated command in a separate Kali, WSL, or PowerShell terminal.
