# AICodex — Local CTF & Cybersecurity Assistant

A practical Ollama setup for a local, offline-first cybersecurity assistant built around **Qwen2.5-Coder 14B**.

It is designed for authorized CTFs, homelabs, defensive security work, PowerShell/Bash command generation, log analysis, and learning workflows. It is not an autonomous exploitation tool: have it produce a command, run it in your own lab or CTF environment, then verify the result.

![AICodex pipeline validation](assets/aicodex-pipeline.svg)

## Why use a heavier 14B model on modest hardware?

The ThinkPad used for this project has an Intel Core 7 240H, 32 GB DDR5 memory, and Intel integrated graphics. That means local inference is constrained mostly by CPU and shared memory—not dedicated GPU VRAM.

We still chose `qwen2.5-coder:14b` because the smaller models were fast but unreliable in the exact workflows that matter for CTF learning:

| Model | Download size | Observed role | Decision |
| --- | ---: | --- | --- |
| [`qwen3:1.7b`](https://ollama.com/library/qwen3) | ~1.4 GB | Quick chat and lightweight help | Too weak for dependable multi-step CTF work |
| [`qwen3:4b`](https://ollama.com/library/qwen3) | ~2.5 GB | Better general assistant | Can become slow or verbose when reasoning |
| [`qwen2.5-coder:3b`](https://ollama.com/library/qwen2.5-coder) | ~1.9 GB | Fast code snippets | Missed simple decode/format tasks |
| [`qwen2.5-coder:14b`](https://ollama.com/library/qwen2.5-coder) | ~9.0 GB | Kali/Bash and PowerShell command generation | **Chosen** |

The goal is not to make the laptop compete with a desktop GPU. The goal is to accept slower generation in exchange for substantially better command construction, instruction-following, and troubleshooting. For exact transformations, use the command it provides and verify output locally.

## Quick start

1. [Install Ollama](https://ollama.com/download).
2. Download the base model:

   ```powershell
   ollama pull qwen2.5-coder:14b
   ```

3. Clone this repository or download the `Modelfile`.
4. Create the custom model from the repository root:

   ```powershell
   ollama create aicodex -f .\Modelfile
   ollama run aicodex
   ```

5. Use a new session for each separate CTF task when context starts to affect answers.

See [setup details](docs/SETUP.md), [validation tests](docs/VALIDATION.md), and [troubleshooting](docs/TROUBLESHOOTING.md).

## Safe, effective workflow

1. Tell AICodex the task is an authorized CTF, lab, or owned system.
2. Ask it for a copyable command in the correct shell.
3. Run that command in a separate PowerShell, Kali, WSL, or lab terminal.
4. Feed the actual output back to AICodex for the next step.

This keeps the model useful without trusting it to silently calculate every flag or execute anything on your host.

## Example: layered CTF artifact

Given a payload that is hex → gzip → Base64 → ROT13, AICodex produced this valid Kali pipeline:

```bash
echo "1f8b08000000000000034b36ce294df128a94ac9752b4d0db32c8bcc8dca8d30f22b8dca8daa4c8e30b0e5020008b6302721000000" | xxd -r -p | gzip -d | base64 -d | tr 'a-zA-Z' 'n-za-mN-ZA-M'
```

Output:

```text
flag{final_boss_passed}
```

## Repository layout

```text
.
├── Modelfile                 # Custom AICodex behavior on Qwen2.5-Coder 14B
├── docs/
│   ├── SETUP.md
│   ├── TROUBLESHOOTING.md
│   └── VALIDATION.md
├── scripts/
│   ├── decode_layers.sh
│   └── decode_layers.ps1
└── assets/                   # Terminal-style screenshots for the README
```

## Limits

- A Modelfile changes behavior and response style; it does not train or upgrade the base model.
- A local Ollama chat does not execute commands. Use a separate terminal or an approved agent workflow in a disposable CTF workspace.
- The 14B model can still make mistakes. Treat generated commands as suggestions and validate them before use.

## License

MIT. See [LICENSE](LICENSE).
