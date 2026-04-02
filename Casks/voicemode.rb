# Homebrew Cask for Voice Mode
# Install: brew install --cask mhkey/voicemode-dev/voicemode

cask "voicemode" do
  version "0.3.0"
  sha256 "544370d1307061f371504945c8a88c93aee352bf7b0c338a0afb62b3191f911a"

  url "https://github.com/mhkey/homebrew-voicemode-dev/releases/download/v#{version}/VoiceMode-#{version}.zip",
      header: "Authorization: token #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}"
  name "Voice Mode"
  desc "Local voice-to-text dictation for coding on macOS — fully on-device, Apple Silicon"
  homepage "https://github.com/mhkey/ProjectAI"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "VoiceMode.app"

  zap trash: [
    "~/Library/Application Support/VoiceMode",
    "~/.config/voice-mode",
  ]

  caveats <<~EOS
    Voice Mode requires:
      - Apple Silicon Mac (M1/M2/M3/M4)
      - macOS 15 (Sequoia) or later
      - Microphone + Accessibility permissions (grant when prompted)
      - GitHub token: export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)
        Add this to your ~/.zshrc to persist it.

    First launch downloads ML models (~1 GB). This only happens once.

    Config: ~/.config/voice-mode/
  EOS
end
