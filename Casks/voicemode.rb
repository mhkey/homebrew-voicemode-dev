# Homebrew Cask for Voice Mode
# Install: brew install --cask voicemode

cask "voicemode" do
  version "0.4.5"
  sha256 "f1b68a9352439b598451fec7a4bfb7fdf039e6c751d6bc2eec986853db71f75a"

  url "https://github.com/mhkey/homebrew-voicemode/releases/download/v#{version}/VoiceMode-#{version}.zip"
  name "Voice Mode"
  desc "Local voice-to-text dictation for coding on macOS — fully on-device, Apple Silicon"
  homepage "https://github.com/mhkey/homebrew-voicemode"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "VoiceMode.app"

  zap trash: [
    "~/Library/Application Support/VoiceMode",
    "~/.config/voice-mode",
    "~/Library/Caches/models",
    "~/Documents/huggingface/models/argmaxinc/whisperkit-coreml",
  ]

  caveats <<~EOS
    Voice Mode requires:
      - Apple Silicon Mac (M1/M2/M3/M4)
      - macOS 15 (Sequoia) or later
      - Microphone + Accessibility permissions (grant when prompted)

    First launch downloads ML models (~1 GB). This only happens once.

    Config: ~/.config/voice-mode/
  EOS
end
