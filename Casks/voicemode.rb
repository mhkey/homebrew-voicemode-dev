# Homebrew Cask for Voice Mode
# Install: brew install --cask mhkey/voicemode-dev/voicemode

cask "voicemode" do
  version "0.2.0b1"
  sha256 "d61a017a433eab793e5b833f9c7ff88cfd3415a90848d970db96e4fd414dd780"

  url "https://github.com/mhkey/ProjectAI/releases/download/v#{version}/VoiceMode-#{version}.zip"
  name "Voice Mode"
  desc "Local voice-to-text dictation for coding on macOS — fully on-device, Apple Silicon"
  homepage "https://github.com/mhkey/ProjectAI"

  # Apple Silicon only (MLX requirement)
  arch arm_only: true

  depends_on macos: ">= :sonoma"

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
      - Python 3.10+ (install via: brew install python@3.11)
      - Microphone + Accessibility permissions (grant when prompted)

    First launch downloads ~2.4 GB of ML models. This only happens once.

    Config:  ~/.config/voice-mode/
    Python:  ~/Library/Application Support/VoiceMode/venv/
  EOS
end
