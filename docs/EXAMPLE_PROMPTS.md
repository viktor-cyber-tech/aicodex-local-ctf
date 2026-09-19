# Example Prompts

Use these as copy-paste starting points for **authorized** CTFs, labs, coursework, and defensive exercises.

## Reliable workflow

AICodex is most useful when it generates a command and you run it in your own terminal. For exact flags, hashes, encodings, and file output, tell it **not to guess**—ask for a command that calculates the result.

1. State the environment: Kali, WSL, Windows PowerShell 5.1, or another shell.
2. State that the work is an authorized CTF, lab, or owned system.
3. Give the artifact, output, or task exactly as provided.
4. Ask for a copyable command or a short plan.
5. Run the command separately and paste the real output back.

## 1. Decode an exact value on Kali

```text
Authorized offline CTF on Kali Linux.

Do not guess or decode the final flag in your head. Give exactly one copyable Bash command that calculates the final result and prints it.

This value is Base64-encoded, then the decoded text is ROT13-encoded:
c3ludHtmcnBoZXJfcGdzfQ==

Return only the command—no explanation.
```

## 2. Decode hex → Base64 on Windows PowerShell 5.1

```text
Authorized offline CTF on Windows PowerShell 5.1.

Give a copyable PowerShell script that:
1. Converts this hex string to ASCII with a loop using Substring and ToByte.
2. Treats the result as Base64.
3. Decodes it as UTF-8 and prints the result.

Do not use [Convert]::FromHexString. Return only the code block.

[PASTE HEX HERE]
```

## 3. Identify layers before decoding

```text
Authorized CTF on Kali Linux.

Analyze this value and identify the likely encoding or compression layers. Do not give a final flag. Give a short numbered plan and the safest standard command for each layer.

[PASTE VALUE HERE]
```

## 4. Create a layered Bash pipeline

```text
Authorized offline CTF on Kali Linux.

The value below is hex-encoded. After hex decoding, it is gzip-compressed; the decompressed text is Base64; the Base64 output is ROT13.

Return only one Bash command that prints the final result. Do not guess the flag—make the command calculate it.

[PASTE VALUE HERE]
```

## 5. Safe file triage

```text
Authorized CTF on Kali Linux. I have a challenge file at ./challenge.bin.

Do not execute the file or suggest destructive commands. Give a short, non-destructive triage sequence using standard tools such as file, sha256sum, strings, xxd, binwalk, and exiftool. Explain what each result could indicate.

Return Bash commands followed by brief notes.
```

## 6. Explain terminal output

```text
Authorized CTF on Kali Linux.

I ran the command below and got this output. Explain only what the output proves, list the most likely next two steps, and do not invent a flag or missing data.

Command:
[PASTE COMMAND]

Output:
[PASTE OUTPUT]
```

## 7. Web-request analysis in a CTF

```text
Authorized CTF challenge. I captured this HTTP request and response from the challenge instance.

Explain the parameters, cookies, headers, and application behavior that are worth investigating. Keep the guidance specific to this challenge and do not assume access to any other target.

[PASTE REQUEST AND RESPONSE]
```

## 8. Defensive log triage

```text
This is an authorized defensive lab.

Review the log entries below for suspicious activity. Return:
1. A short incident summary
2. The indicators to validate
3. The next safe investigation commands or queries
4. A severity rating with one-sentence reasoning

[PASTE LOGS HERE]
```

## 9. Learn a command instead of blindly running it

```text
Explain this command line by line, including the purpose of every flag and pipe. Then give one safer or more portable alternative if one exists.

[PASTE COMMAND HERE]
```

## 10. Ask AICodex to check its own answer

```text
Before answering, verify that every transformation in your proposed command is necessary and in the correct order. If you are uncertain about a flag or tool behavior, say so instead of inventing it.

Authorized CTF on [Kali Linux / Windows PowerShell 5.1]:
[PASTE TASK]
```

## Reusable template

```text
Authorized [CTF / homelab / defensive lab] on [Kali Linux / Windows PowerShell 5.1].

Goal:
[STATE THE RESULT YOU WANT]

Artifact or evidence:
[PASTE THE VALUE, FILE PATH, REQUEST, OR LOG OUTPUT]

Constraints:
- [Example: Return one copyable Bash command.]
- [Example: Do not guess the flag; calculate and print it.]
- [Example: Use Windows PowerShell 5.1-compatible syntax.]
- [Example: Explain only after the command.]
```

## Accuracy reminders

- Do not treat an AI response as proof that a flag is correct.
- Prefer commands that print the result over asking the model to calculate multi-step transformations mentally.
- Paste actual terminal output back for the next step.
- Use a new Ollama chat session when an old task’s context starts affecting answers.
