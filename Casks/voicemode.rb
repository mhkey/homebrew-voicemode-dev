# Homebrew Cask for Voice Mode
# Install: brew install --cask mhkey/voicemode-dev/voicemode
#
# Requires: export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)

cask "voicemode" do
  version "0.2.0b1"
  sha256 "641fbdde6ba9f52c1a14ec4be241a3d02c8275d236884af5092461b1d941efd5"

  url "https://api.github.com/repos/mhkey/homebrew-voicemode-dev/releases/assets/386179402",
      header: [
        "Authorization: token #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
        "Accept: application/octet-stream",
      ]
  name "Voice Mode"
  desc "Local voice-to-text dictation for coding on macOS — fully on-device, Apple Silicon"
  homepage "https://github.com/mhkey/ProjectAI"

  # Apple Silicon only (MLX requirement)
  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"
  depends_on formula: "pyenv"

  app "VoiceMode.app"

  postflight do
    setup_script = "#{appdir}/VoiceMode.app/Contents/Resources/setup-python.sh"
    if File.exist?(setup_script)
      ohai "Setting up Voice Mode Python environment (this may take a few minutes)..."
      system_command "/bin/bash",
                     args: [setup_script],
                     print_stderr: true
    end
  end

  uninstall_postflight do
    venv_dir = File.expand_path("~/Library/Application Support/VoiceMode/venv")
    if Dir.exist?(venv_dir)
      ohai "Removing Voice Mode Python environment..."
      system_command "/bin/rm", args: ["-rf", venv_dir]
    end
  end

  zap trash: [
    "~/Library/Application Support/VoiceMode",
    "~/.config/voice-mode",
  ]

  caveats <<~EOS
    Voice Mode requires:
      - Apple Silicon Mac (M1/M2/M3/M4)
      - Microphone + Accessibility permissions (grant when prompted)
      - GitHub token: export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)
        Add this to your ~/.zshrc to persist it.

    Python 3.11 is installed automatically via pyenv during setup.

    First launch downloads ~2.4 GB of ML models. This only happens once.

    Config:  ~/.config/voice-mode/
    Python:  ~/Library/Application Support/VoiceMode/venv/
  EOS
end
