# Troubleshooting

## The model is slow

- The 14B model fits in 32 GB RAM, but integrated Intel graphics do not provide desktop-class inference speed.
- Keep the laptop plugged in and use Windows **Best performance** power mode.
- Ask for concise outputs and commands rather than long tutorials.
- Start a fresh `ollama run aicodex` session when a conversation becomes long.

## A response stops mid-sentence

Do not set a low `PARAMETER num_predict` value in the Modelfile. A hard output cap can stop the model before it reaches the command or final answer.

## The model gives a command but not the flag

That is expected when you asked it for code only. Copy the command into your separate terminal; the terminal prints the actual output.

## `FromHexString` does not exist in PowerShell

Windows PowerShell 5.1 does not provide `[Convert]::FromHexString()`. Use a byte loop instead:

```powershell
$bytes = for ($i = 0; $i -lt $hex.Length; $i += 2) {
    [Convert]::ToByte($hex.Substring($i, 2), 16)
}
```

## The model guesses a flag or transformation incorrectly

Do not trust an LLM to perform every multi-step transform mentally. Ask it for a command, execute the command, and use the observed output as the next input. This is both faster to verify and more reliable.

## The model is verbose

Ask for “one copyable command only” or “reply with only the final flag.” The model may occasionally add Markdown fences; the content inside the block can still be valid.
