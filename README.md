# Super Voice Mode

Local voice-to-text dictation and voice AI assistant for macOS. Fully native Swift — nothing leaves your machine.

Hold the **Right Option key**, speak, release. Your words appear as text wherever your cursor is.

<img width="660" height="732" alt="image" src="https://github.com/user-attachments/assets/3ec98aba-4ab4-42f2-9d50-486066daacea" />

## Features

### Dictation Mode
Speech-to-text optimised for code. Understands spoken punctuation, operators, casing commands, and programming constructs. Uses Parakeet (NVIDIA) and Whisper (OpenAI) running locally via CoreML on Apple Silicon.

- Spoken code operators: "underscore", "dot", "dash", bracket pairs
- Spoken punctuation: "comma", "colon", "semicolon", etc.
- Smart formatting: detects CODE vs PROSE context from the active app
- LLM correction: Qwen 2.5 Coder fixes coding jargon using context from your active editor
- Custom word replacements and filler stripping
- "Scratch that" to undo the last dictation

### Assistant Mode
Voice-powered AI assistant that connects to your existing coding agents. Say the trigger word (default: "computer") followed by a question or command.

<img width="660" height="732" alt="image" src="https://github.com/user-attachments/assets/92f9184f-e9ac-469f-9b34-35401414f673" />

**Supported backends:**

| Backend | What it uses | How it connects |
|---------|-------------|-----------------|
| **Claude** | Anthropic Claude | Runs Claude with your existing config, MCP servers, and project context |
| **Codex** | OpenAI Codex | Runs Codex with sandboxed execution and configurable permissions |
| **Ollama** | Local Ollama API | Connects to any model running in Ollama |
| **Local LLM** | Qwen 2.5 Coder (MLX) | Fully offline, no external dependencies |

Assistant mode auto-detects which backends are installed. When connected to Claude or Codex, your voice commands have access to everything those agents can reach — MCP servers (Slack, Jira, Google, etc.), codebase context, and tools.

**Paste mode:** Say "computer paste, write a hello world function" — the response gets inserted at your cursor instead of spoken aloud.

### Text-to-Speech
Assistant responses are spoken back using local TTS (Kokoro MLX or Piper). Streaming sentence-by-sentence for low latency.

## Requirements

- Apple Silicon Mac (M1/M2/M3/M4)
- macOS 15 Sequoia or later
- [Homebrew](https://brew.sh) installed

## Install

```bash
brew tap mhkey/voicemode
brew install --cask voicemode
```

### First launch

1. Open **Finder** > **Applications** > **VoiceMode**
2. macOS will warn about an unidentified developer. Fix:
   ```bash
   xattr -cr /Applications/VoiceMode.app
   open /Applications/VoiceMode.app
   ```
3. Grant **Microphone** permission when prompted
4. Grant **Accessibility** permission when prompted (System Settings opens — toggle Voice Mode on)
5. Wait for ML models to download (~2.4 GB, one-time)

### Use it

A mic icon appears in your menu bar (top-right). Hold **Right Option key** > speak > release. Text appears at your cursor.

<img width="660" height="732" alt="image" src="https://github.com/user-attachments/assets/505c136d-8e84-4f1a-a6ae-b225646315f4" />

Try saying "shiver me timbers" or "chuck another shrimp on the barbie" — it'll type it out for you.

## Update

The app checks for updates automatically on launch. Or manually:

```bash
brew upgrade --cask voicemode
```

## Uninstall

```bash
brew uninstall --cask voicemode
```

To also remove config and cached models:

```bash
brew uninstall --zap voicemode
```

This removes `~/.config/voice-mode/`, cached ML models, and app support data.

## Configuration

All config files are hot-reloaded — edit them and changes apply immediately.

| File | Purpose |
|------|---------|
| `~/.config/voice-mode/settings.json` | App settings |
| `~/.config/voice-mode/rules.txt` | Custom LLM correction rules |
| `~/.config/voice-mode/replacements.txt` | Word replacements (find → replace) |

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `brew tap` fails | Check internet connection and try again |
| App won't open / Gatekeeper | `xattr -cr /Applications/VoiceMode.app` then try again |
| Splash screen shows error | Run `/Applications/VoiceMode.app/Contents/MacOS/VoiceMode` in Terminal to see full error |
| "Does not compute" | That's not a bug. |
| Models stuck downloading | Quit (menu bar icon > Quit), reopen. Check internet. |
| Accessibility not working | System Settings > Privacy & Security > Accessibility > toggle Voice Mode off then on |
| Microphone not working | System Settings > Privacy & Security > Microphone > ensure Voice Mode is checked |

---

*"We need to disrupt this space."*
