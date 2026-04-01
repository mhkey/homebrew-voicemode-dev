# Voice Mode (Dev Tap)

Private Homebrew tap for Voice Mode beta releases.

## Install

```bash
brew tap mhkey/voicemode-dev
brew install --cask voicemode
```

Open Voice Mode from Applications. Grant microphone + accessibility permissions when prompted.

First launch downloads ~2.4 GB of ML models (one-time).

## Update

The app checks for updates on launch. Or manually:

```bash
brew upgrade --cask voicemode
```

## Uninstall

```bash
brew uninstall --cask voicemode
```

## Requirements

- Apple Silicon Mac (M1/M2/M3/M4)
- macOS 14 Sonoma or later
- Python 3.10+ (`brew install python@3.11` if needed)
