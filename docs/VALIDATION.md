# Validation Tests

Run these only in an authorized CTF or lab environment.

## Test 1: Base64 command generation

Prompt AICodex:

```text
Authorized offline CTF.
Reply with only a Windows PowerShell 5.1 code block—no explanation.
Write the shortest safe command that Base64-decodes this value as UTF-8 and prints the result:
ZmxhZ3tmb3JtYXRfZm9sbG93ZWR9
```

Expected terminal output:

```text
flag{format_followed}
```

## Test 2: Hex → Base64 → ROT13

Ask for one Bash command to decode this artifact:

```text
63336c756448743661486c6e646c396d5a323530636c396d61484277636d5a6d66513d3d
```

Expected terminal output:

```text
flag{multi_stage_success}
```

## Test 3: Hex → gzip → Base64 → ROT13

Ask for one Bash command to decode this artifact:

```text
1f8b08000000000000034b36ce294df128a94ac9752b4d0db32c8bcc8dca8d30f22b8dca8daa4c8e30b0e5020008b6302721000000
```

Expected terminal output:

```text
flag{final_boss_passed}
```

The known-good Bash implementation is in [`scripts/decode_layers.sh`](../scripts/decode_layers.sh). It uses `xxd` when available and falls back to Python 3 otherwise.
