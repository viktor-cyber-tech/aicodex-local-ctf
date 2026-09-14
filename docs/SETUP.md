# Setup

## Prerequisites

- Windows 11 with 32 GB RAM recommended for `qwen2.5-coder:14b`.
- Ollama installed and running.
- At least 12 GB of free disk space for the base model and local cache.

## Create AICodex

From the repository folder in PowerShell:

```powershell
ollama pull qwen2.5-coder:14b
ollama create aicodex -f .\Modelfile
ollama run aicodex
```

Confirm the model exists:

```powershell
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
